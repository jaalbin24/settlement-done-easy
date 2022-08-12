class StripeController < ApplicationController
    before_action :authenticate_user!, except: :handle_event

    # Skip CSRF Authentication for the webhook endpoint. Requests will be authenticated using the endpoint secret as described at https://stripe.com/docs/webhooks/signatures
    skip_before_action :verify_authenticity_token, :only => [:handle_event]

    def onboard_account_link
        user = current_user
        if user.isOrganization?
            if user.stripe_account_onboarded?
                flash[:info] = "Account already onboarded. No action needed."
                redirect_to root_path
                return
            end
            if user.stripe_account_id.blank?
                # Create a Stripe Connect account for the user
            end
            account_link = Stripe::AccountLink.create(
                account: user.stripe_account_id,
                refresh_url: "#{Rails.configuration.URL_ROOT}/stripe_handle_return_from_onboard",
                return_url: "#{Rails.configuration.URL_ROOT}/stripe_handle_return_from_onboard",
                type: 'account_onboarding',
            )
            redirect_to account_link.url
        else
            handle_invalid_request
        end
    end

    # For attorneys to sign in to their Stripe Express account and view that Dashboard
    def login_link
        user = current_user
        if user.isLawFirm?
            if user.stripe_account_id.blank?
                redirect_to stripe_onboard_account_link_url
            else
                login_link = Stripe::Account.create_login_link(user.stripe_account_id)
                redirect_to login_link.url
            end
        else
            handle_invalid_request
        end
    end

    def handle_return_from_onboard
        @stripe_account = Stripe::Account.retrieve(current_user.stripe_account_id)
        if @stripe_account.charges_enabled
            current_user.stripe_account_onboarded = true
            if current_user.save
                render :onboard_complete
            else
                flash[:info] = "Stripe onboarding completed, but there was a server error. #{current_user.errors.full_messages.inspect}"
                redirect_back(fallback_location: root_path)
            end
        else
            current_user.stripe_account_onboarded = false
            if current_user.save
                render :onboard_not_complete
            else
                flash[:info] = "Stripe onboarding not completed, and there was a server error. #{current_user.errors.full_messages.inspect}"
                redirect_back(fallback_location: root_path)
            end
        end
    end

    def onboard_complete
        render :onboard_complete
    end

    def onboard_not_complete
        render :onboard_not_complete
    end

    def initiate_settlement_payment
        begin
            settlement = Settlement.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
        if current_user.organization == nil
            flash[:info] = "You must belong to an organization to make payments. Click <a href=#{organization_join_path}>here<a> to join an organization."
            redirect_back(fallback_location: root_path)
            return
        elsif settlement.insurance_agent.organization.bank_accounts.empty?
            flash[:info] = "You cannot make payments because #{settlement.insurance_agent.organization.full_name} does not have a bank account on file."
            redirect_back(fallback_location: root_path)
            return
        elsif !settlement.attorney.organization.stripe_account_onboarded?
            flash[:info] = "You cannot make payments because #{settlement.attorney.organization.full_name} has not set up payment details."
            redirect_back(fallback_location: root_path)
            return
        elsif !current_user.isInsuranceAgent?
            flash[:info] = "#{current_user.role.pluralize.capitalize} cannot pay settlements."
            redirect_back(fallback_location: root_path)
            return
        end
        settlement.initiate_payment
        redirect_back(fallback_location: root_path)
    end

    def handle_event
        payload = request.body.read
        event = nil

        begin
            event = Stripe::Event.construct_from(
                JSON.parse(payload, symbolize_names: true)
            )
        rescue JSON::ParserError => e
            # Invalid payload
            puts "⚠️Webhook error while parsing basic request. #{e.message})"
            head 400
            return
        end
        # Check if webhook signing is configured.
        endpoint_secret = Rails.configuration.STRIPE_ENDPOINT_SECRET
        if !endpoint_secret.blank?
            # Retrieve the event by verifying the signature using the raw body and secret.
            signature = request.env['HTTP_STRIPE_SIGNATURE'];
            begin
                event = Stripe::Webhook.construct_event(
                    payload, signature, endpoint_secret
                )
            rescue Stripe::SignatureVerificationError => e
                puts "⚠️ Webhook signature verification failed. #{e.message})"
                head 400
                return
            end
        else
            puts "⚠️ Webhook signature verification incomplete."
            head 400
            return
        end

        case event.type
        when "treasury.financial_account.features_status_updated"

        when "capability.updated"
            puts event
        when "person.created"
            puts event
        when "person.updated"
            puts event
        when "account.updated"
            puts event
        when "account.external_account.created"
            puts event
        when "account.external_account.updated"
            puts event
        when "financial_connections.account.created"
            puts event
        when "setup_intent.created"
            puts event
        when "setup_intent.succeeded"
            puts event
        when "payment_method.attached"
            puts event
            payment_method = event.data.object
            user = User.where("stripe_account_id=?", event.account).first
            bank_account = BankAccount.where("stripe_payment_method_id=?", payment_method.id).first

            if !bank_account.nil?
                bank_account.update(
                    stripe_payment_method_id: event.data.object.id,
                    nickname: payment_method.us_bank_account.bank_name,
                    last4: payment_method.us_bank_account.last4,
                )
            else
                bank_account = user.bank_accounts.build(
                    stripe_payment_method_id: event.data.object.id,
                    nickname: payment_method.us_bank_account.bank_name,
                    last4: payment_method.us_bank_account.last4,
                )
                bank_account.save
            end
        when "treasury.inbound_transfer.created"
            puts event
        when "treasury.inbound_transfer.succeeded"
            puts event
            inbound_transfer = event.data.object
            user = User.where("stripe_account_id=?", event.account).first
            payment = Payment.where("stripe_inbound_transfer_id=?", inbound_transfer.id).first
            if payment.nil?
                puts "❗❗❗ PAYMENT DOES NOT EXIST ❗❗❗"
                puts payment
            else
                puts payment
                payment.execute_outbound_payment
            end
        when "treasury.outbound_payment.created"
            puts event
        when "treasury.outbound_payment.posted"
            puts event
            outbound_payment = event.data.object
            user = User.where("stripe_account_id=?", event.account).first
            payment = Payment.where("stripe_outbound_payment_id=?", outbound_payment.id).first
            if payment.nil?
                puts "❗❗❗ PAYMENT DOES NOT EXIST ❗❗❗"
                puts payment
            else
                puts payment
                payment.execute_outbound_transfer
            end
        when "treasury.outbound_transfer.created"
            puts event
            outbound_transfer = event.data.object
            user = User.where("stripe_account_id=?", event.account).first
            payment = Payment.where("stripe_outbound_transfer_id=?", outbound_transfer.id).first
            if payment.nil?
                puts "❗❗❗ PAYMENT DOES NOT EXIST ❗❗❗"
                puts payment
            else
                puts payment
                payment.complete
            end
        when "treasury.outbound_transfer.posted"
        else
            puts "❗❗❗ Unhandled event type: #{event.type} ❗❗❗"
            puts event
        end
    end
end
