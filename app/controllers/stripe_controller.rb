class StripeController < ApplicationController
    def onboard_account_link
        user = current_user
        if user.isLawyer?
            account_link = Stripe::AccountLink.create(
                account: user.stripe_account_id,
                refresh_url: 'http://localhost:3000/stripe_handle_return_from_onboard',
                return_url: 'http://localhost:3000/stripe_handle_return_from_onboard',
                type: 'account_onboarding',
            )
            redirect_to account_link.url
        else
            handle_invalid_request
        end
    end

    # For lawyers to sign in to their Stripe Express account and view that Dashboard
    def login_link
        user = current_user
        if user.isLawyer?
            login_link = Stripe::Account.create_login_link(current_user.stripe_account_id)
            redirect_to login_link.url
        else
            handle_invalid_request
        end
    end

    def handle_return_from_onboard
        @stripe_account = Stripe::Account.retrieve(current_user.stripe_account_id)
        if @stripe_account.charges_enabled
            render :onboard_complete
        else
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
            success_url: "http://localhost:3000/settlements/#{settlement.id}/payment_success",
            cancel_url: "http://localhost:3000/",
            payment_method_types: [
                "us_bank_account"
            ],
            payment_intent_data: {
                application_fee_amount: 500,
                transfer_data: {
                    destination: settlement.lawyer.stripe_account_id,
                },
            },
        })
        redirect_to stripe_session.url
    end
end
