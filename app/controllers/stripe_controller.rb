class StripeController < ApplicationController
    before_action :authenticate_user!, except: :handle_event

    # Skip CSRF Authentication for the webhook endpoint. Requests will be authenticated using the endpoint secret as described at https://stripe.com/docs/webhooks/signatures
    skip_before_action :verify_authenticity_token, :only => [:handle_event]

    def onboard_account_link
        if current_user.isOrganization?
            if current_user.stripe_account.onboarded?
                flash[:primary] = "Account already onboarded. No action needed."
                redirect_to root_path
                return
            end
            if current_user.stripe_account.stripe_id.blank?
                if current_user.isOrganization? && !current_user.stripe_account.onboarded?
                    unless Rails.env.test?
                        account = Stripe::Account.create({
                            type: "custom",
                            country: "US",
                            capabilities: {
                                treasury: {requested: true},
                                us_bank_account_ach_payments: {requested: true},
                                card_payments: {requested: true},
                                transfers: {requested: true},
                            },
                            business_type: "company",
                            business_profile: {url: "http://settlementdoneeasy.com/"},
                        })
                        current_user.stripe_account.stripe_id = account.id
                        current_user.stripe_account.sync_with(account)
                        current_user.stripe_account.save
                    end
                end
            end
            account_link = Stripe::AccountLink.create(
                account: current_user.stripe_account.stripe_id,
                refresh_url: "#{ENV['APP_URL_DOMAIN']}/stripe_handle_return_from_onboard",
                return_url: "#{ENV['APP_URL_DOMAIN']}/stripe_handle_return_from_onboard",
                type: 'account_onboarding',
            )
            redirect_to account_link.url
        else
            handle_invalid_request
        end
    end

    def handle_return_from_onboard 
        # TODO: Revamp this whole action. There should be a stronger check for the requirements from Stripe
        # than just checking whether charges are enabled.
        @stripe_account = Stripe::Account.retrieve(current_user.stripe_account.stripe_id)
        if @stripe_account.charges_enabled
            if current_user.save
                render :onboard_complete
            else
                flash[:primary] = "Stripe onboarding completed, but there was a server error. #{current_user.errors.full_messages.inspect}"
                redirect_to root_path
            end
        else
            if current_user.save
                render :onboard_not_complete
            else
                flash[:primary] = "Stripe onboarding not completed, and there was a server error. #{current_user.errors.full_messages.inspect}"
                redirect_to root_path
            end
        end
    end

    def onboard_complete
        render :onboard_complete
    end

    def onboard_not_complete
        render :onboard_not_complete
    end

    def handle_event
        payload = request.body.read
        dubious_event = nil

        begin
            dubious_event = Stripe::Event.construct_from(
                JSON.parse(payload, symbolize_names: true)
            )
        rescue JSON::ParserError => e
            # Invalid payload
            puts "⚠️Webhook error while parsing basic request. #{e.message})"
            head 400
            return
        end
        # Check if webhook signing is configured.
        endpoint_secret = ENV['STRIPE_ENDPOINT_SECRET']
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
        puts event
        case event.type
        when "setup_intent.succeeded"
            setup_intent = event.data.object

            # The user who started the setupIntent should have been stored in the metadata.
            added_by = User.find_by(public_id: setup_intent.metadata.added_by)
            # But if that user is not found, the organization corresponding to the account id will be listed as the one who added the bank account.
            added_by = User.joins(:stripe_account).where(stripe_account: {stripe_id: event.account}).distinct.first if added_by.nil?
            
            payment_method = Stripe::PaymentMethod.retrieve(
                setup_intent.payment_method,
                {stripe_account: event.account}
            )
            bank_account = added_by.payment_methods.build(
                type: "BankAccount",
                stripe_id: payment_method.id,
                last4: payment_method.us_bank_account.last4,
                status: setup_intent.status,
                bank_name: payment_method.us_bank_account.bank_name,
            )
            if bank_account.save!
                head 200
            else
                # Send yourself an email
            end
        when "account.updated"
            remote_stripe_account = event.data.object
            local_stripe_account = StripeAccount.find_by(stripe_id: event.account)
            if local_stripe_account == nil
                puts "❗❗❗ No local Stripe account with id \"#{remote_stripe_account.id}\" found ❗❗❗"
                head 400
                return
            else
                puts "❤️❤️❤️❤️ BEFORE SYNC ❤️❤️❤️❤️"
                local_stripe_account.sync_with(remote_stripe_account)
                puts "❤️❤️❤️❤️ AFTER SYNC ❤️❤️❤️❤️"
                if !local_stripe_account.save
                    puts "⚠️⚠️⚠️ ERROR saving Stripe Account: #{local_stripe_account.errors.full_messages.inspect}"
                end
            end
        when "treasury.inbound_transfer.failed"
            inbound_transfer = event.data.object
            payment = Payment.with_inbound_transfer_id(inbound_transfer.id).first
            payment.fail_payment
            # No big deal if the inbound transfer fails. No money was taken, so no money needs to be given back.
        when "treasury.inbound_transfer.succeeded"
            inbound_transfer = event.data.object
            payment = Payment.with_inbound_transfer_id(inbound_transfer.id).first
            if payment.nil?
                # Send yourself an email.
                puts "❗❗❗ PAYMENT DOES NOT EXIST ❗❗❗"
                head 400
            else
                puts payment
                payment.execute_outbound_payment
            end
        when "treasury.outbound_payment.posted"
            outbound_payment = event.data.object
            payment = Payment.with_outbound_payment_id(outbound_payment.id).first
            if payment.nil?
                puts "❗❗❗ PAYMENT DOES NOT EXIST ❗❗❗"
                head 400
            else
                puts payment
                payment.execute_outbound_transfer
            end
        when "treasury.outbound_transfer.posted"
            outbound_transfer = event.data.object
            payment = Payment.with_outbound_transfer_id(outbound_transfer.id).first
            if payment.nil?
                puts "❗❗❗ PAYMENT DOES NOT EXIST ❗❗❗"
                head 400
            else
                puts payment
                payment.complete_payment
            end
        else
            puts "❗❗❗ Unhandled event type: #{event.type} ❗❗❗"
        end
    end
end
