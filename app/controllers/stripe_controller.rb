class StripeController < ApplicationController
    before_action :authenticate_user!
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
                refresh_url: "http://#{Rails.configuration.URL_DOMAIN}/stripe_handle_return_from_onboard",
                return_url: "http://#{Rails.configuration.URL_DOMAIN}/stripe_handle_return_from_onboard",
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
            login_link = Stripe::Account.create_login_link(current_user.stripe_account_id)
            redirect_to login_link.url
        else
            handle_invalid_request
        end
    end

    def handle_return_from_onboard
        @stripe_account = Stripe::Account.retrieve(current_user.stripe_account_id)
        if @stripe_account.charges_enabled
            current_user.stripe_account_onboarded = true
            render :onboard_complete
        else
            current_user.stripe_account_onboarded = false
            render :onboard_not_complete
        end
    end

    def onboard_complete
        render :onboard_complete
    end

    def onboard_not_complete
        render :onboard_not_complete
    end

    def settlement_checkout_session
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
        elsif !current_user.organization.stripe_account_onboarded?
            flash[:info] = "You cannot make payments because #{current_user.organization.full_name} has not set up payment details."
            redirect_back(fallback_location: root_path)
            return
        end
        settlement.init_stripe_data
        stripe_session = Stripe::Checkout::Session.create({
            line_items: [{
                price: settlement.stripe_price_id,
                quantity: 1,
            }],
            mode: "payment",
            success_url: "http://#{Rails.configuration.URL_DOMAIN}/settlements/#{settlement.id}/payment_success",
            cancel_url: "http://#{Rails.configuration.URL_DOMAIN}/",
            payment_method_types: [
                "us_bank_account"
            ],
            payment_intent_data: {
                transfer_data: {
                    destination: settlement.attorney.organization.stripe_account_id,
                },
            },
        })
        settlement.stripe_payment_intent_id = stripe_session.payment_intent
        if !settlement.save
            puts "=========================== ERROR: SETTLEMENT NOT SAVED: #{settlement.errors.full_messages.inspect}"
        end
        redirect_to stripe_session.url
    end

    def get_payment_status
        begin
            settlement = Settlement.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
        stripe_payment_intent = Stripe::PaymentIntent.retrieve(settlement.stripe_payment_intent_id)
        if stripe_payment_intent.status == "processing"
            flash[:info] = "Payment still processing."
            redirect_to settlement_show_path(settlement)
        elsif stripe_payment_intent.status == "succeeded"
            settlement.payment_received = true
            settlement.save
            flash[:success] = "Payment of $#{stripe_payment_intent.amount/100.0} has been received for claim #{settlement.claim_number}. Click <a href='#{settlement_complete_path(settlement)}'>here<a> to complete this settlement."
            redirect_to settlement_show_url(settlement)
        else
            handle_invalid_request
        end
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
            puts "??????  Webhook error while parsing basic request. #{e.message})"
            status 400
            return
        end
        # Check if webhook signing is configured.
        if endpoint_secret
            # Retrieve the event by verifying the signature using the raw body and secret.
            signature = request.env['HTTP_STRIPE_SIGNATURE'];
            begin
                event = Stripe::Webhook.construct_event(
                    payload, signature, endpoint_secret
                )
            rescue Stripe::SignatureVerificationError => e
                puts "??????  Webhook signature verification failed. #{e.message})"
                status 400
            end
        end
        status 200
        case event.type
        when 'payment_intent.succeeded'
            payment_intent = event.data.object # contains a Stripe::PaymentIntent
            puts "Payment for #{payment_intent['amount']} succeeded."
            # Then define and call a method to handle the successful payment intent.
            # handle_payment_intent_succeeded(payment_intent)
        when 'payment_method.attached'
            payment_method = event.data.object # contains a Stripe::PaymentMethod
            # Then define and call a method to handle the successful attachment of a PaymentMethod.
            # handle_payment_method_attached(payment_method)
        else
            puts "Unhandled event type: #{event.type}"
        end
    end

    def add_payment_method
        user = current_user
        if user.isInsuranceCompany?
            if user.stripe_account_id == nil
                customer = Stripe::Customer.create(
                    name: user.business_name,
                    email: user.email
                )
                user.stripe_account_id = customer.id
                user.has_stripe_payment_method = false
                if !user.save
                    flash[:info] = "There was an error creating a Stripe customer object: #{user.errors.full_messages.inspect}"
                    redirect_back(fallback_location: root_path)
                    return
                end
            end
            if !user.has_stripe_payment_method?
                
            end
        else
            handle_invalid_request
            return
        end
         
    end

end
