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
                application_fee_amount: 500,
                transfer_data: {
                    destination: settlement.attorney.stripe_account_id,
                },
            },
        })
        settlement.stripe_payment_intent_id = stripe_session.payment_intent
        if !settlement.save
            puts "=========================== ERROR: SETTLEMENT NOT SAVED"
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
            flash[:success] = "Payment of $#{stripe_payment_intent.amount/100.0} has been received for claim #{settlement.claim_number}."
            redirect_to settlement_show_url(settlement)
        else
            handle_invalid_request
        end
    end
end
