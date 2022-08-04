class StripeController < ApplicationController
    before_action :authenticate_user!, except: :handle_event

    # Skip CSRF Authentication for the webhook endpoint. Requests will be authenticated using the endpoint secret as described at https://stripe.com/docs/webhooks/signatures
    skip_before_action :verify_authenticity_token, :only => [:handle_event]

    def onboard_account_link
        user = current_user
        if user.isLawFirm?
            if user.stripe_account_onboarded?
                flash[:info] = "Account already onboarded. No action needed."
                redirect_to root_path
                return
            end
            if user.stripe_account_id == nil
                account = Stripe::Account.create({
                    type: "express",
                    country: "US",
                    email: user.email,
                    capabilities: {
                        us_bank_account_ach_payments: {requested: true},
                        card_payments: {requested: true},
                        transfers: {requested: true},
                    },
                    business_type: "company",
                    business_profile: {url: "http://settlementdoneeasy.com/"}
                })
                user.stripe_account_id = account.id
                user.save
            end
            account_link = Stripe::AccountLink.create(
                account: user.stripe_account_id,
                refresh_url: "#{Rails.configuration.URL_ROOT}/stripe_handle_return_from_onboard",
                return_url: "#{Rails.configuration.URL_ROOT}/stripe_handle_return_from_onboard",
                type: 'account_onboarding',
            )
            redirect_to account_link.url
        elsif user.isInsuranceCompany?
            if user.stripe_account_id.blank?
                customer = Stripe::Customer.create(
                    name: user.business_name,
                    email: user.email
                )
            end
            redirect_to stripe_add_payment_method_url
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
        elsif !settlement.insurance_agent.organization.has_stripe_bank_account?
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
        settlement.init_stripe_data
        payment_intent = Stripe::PaymentIntent.create(
            amount: (settlement.dollar_amount * 100).round,
            currency: "usd",
            payment_method: settlement.insurance_agent.organization.preferred_payment_method,
            customer: settlement.insurance_agent.organization.stripe_account_id,
            on_behalf_of: settlement.attorney.organization.stripe_account_id,
            payment_method_types: ["us_bank_account"]
        )
        settlement.stripe_payment_intents.build(stripe_id: payment_intent.id)
        if settlement.save
            Stripe::PaymentIntent.confirm(payment_intent.id)
        else
            puts "=========================== ERROR: SETTLEMENT NOT SAVED: #{settlement.errors.full_messages.inspect}"
        end
        redirect_to stripe_session.url
    end

    # def get_payment_status
    #     begin
    #         settlement = Settlement.find(params[:id])
    #     rescue
    #         handle_invalid_request
    #         return 
    #     end
    #     stripe_payment_intent = Stripe::PaymentIntent.retrieve(settlement.stripe_payment_intent_id)
    #     if stripe_payment_intent.status == "processing"
    #         flash[:info] = "Payment still processing."
    #         redirect_to settlement_show_path(settlement)
    #     elsif stripe_payment_intent.status == "succeeded"
    #         settlement.payment_received = true
    #         settlement.save
    #         flash[:success] = "Payment of $#{stripe_payment_intent.amount/100.0} has been received for claim #{settlement.claim_number}. Click <a href='#{settlement_complete_path(settlement)}'>here<a> to complete this settlement."
    #         redirect_to settlement_show_url(settlement)
    #     else
    #         handle_invalid_request
    #     end
    # end

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
        when 'payment_intent.succeeded'
            dubious_payment_intent = event.data.object
            authentic_payment_intent = Stripe::PaymentIntent.retrieve(dubious_payment_intent.id)
            if authentic_payment_intent.status == "succeeded"
                local_payment_intent = StripePaymentIntent.where("stripe_id=?", authentic_payment_intent.id).first
                settlement = local_payment_intent.settlement
                settlement.payment_made = true
                settlement.payment_received = true
                if settlement.save
                    StripePaymentIntent.where("settlement_id=?", settlement.id).destroy_all
                end
                puts "💲💲💲 Payment for #{authentic_payment_intent.amount} succeeded!"
            else
                # TODO: Log this webhook event because it means something fishy has happened.
                return
            end
        when 'payment_method.attached'
            dubious_payment_method = event.data.object
            authentic_payment_method = Stripe::PaymentMethod.retrieve(dubious_payment_method.id)
            user = User.where("stripe_account_id=?", authentic_payment_method.customer).first
            if user.nil?
                # TODO: Log this webhook event because it means something fishy has happened.
            else
                user.stripe_payment_methods.build(stripe_id: authentic_payment_method.id)
                user.has_stripe_payment_method = true
                user.save
            end
        when 'checkout.session.completed'
            dubious_checkout_session = event.data.object
            begin
                authentic_checkout_session = Stripe::Checkout::Session.retrieve(dubious_checkout_session.id)
            rescue Stripe::RateLimitError => e
            # Too many requests made to the API too quickly
            rescue Stripe::InvalidRequestError => e
            # Invalid parameters were supplied to Stripe's API
            rescue Stripe::AuthenticationError => e
            # Authentication with Stripe's API failed
            # (maybe you changed API keys recently)
            rescue Stripe::APIConnectionError => e
            # Network communication with Stripe failed
            rescue Stripe::StripeError => e
            # Display a very generic error to the user, and maybe send
            # yourself an email
            rescue => e
            # Something else happened, completely unrelated to Stripe
            end
            puts "=========== authentic_checkout_session.status=#{authentic_checkout_session.status}"
            if authentic_checkout_session.status == "complete"
                puts "❗ Checkout session completed ❗"
            else
                # TODO: Log this webhook event because it means something fishy has happened.
                return
            end
            user = User.where("stripe_account_id=?", authentic_checkout_session.customer).first
            if user.nil? || !user.isInsuranceCompany?
                # TODO: Log this webhook event because it means something fishy has happened.
                return
            else
                user.has_stripe_payment_method = true
                user.save
            end
        when 'customer.created'
            dubious_customer = event.data.object
            user = User.where("stripe_account_id=?", dubious_customer.id).first
            if user.nil? || !user.isInsuranceCompany?
                # TODO: Log this webhook event because it means something fishy has happened.
                return
            end
        else
            puts "Unhandled event type: #{event.type}"
        end
    end

    def add_payment_method
        user = current_user
        if user.isInsuranceCompany?
            if user.stripe_account_id.blank?
                customer = Stripe::Customer.create(
                    name: user.business_name,
                    email: user.email
                )
                user.stripe_account_id = customer.id
                user.has_stripe_payment_method = false
                if !user.save
                    flash[:info] = "There was an error adding the Stripe customer ID: #{user.errors.full_messages.inspect}"
                    redirect_back(fallback_location: root_path)
                    return
                end
            end
            session = Stripe::Checkout::Session.create(
                payment_method_types: ["us_bank_account"],
                mode: 'setup',
                customer: user.stripe_account_id,
                success_url: "#{Rails.configuration.URL_ROOT}",
                cancel_url: "#{Rails.configuration.URL_ROOT}",
            )
            redirect_to session.url
        else
            handle_invalid_request
            return
        end
    end
end
