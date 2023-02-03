class CardsController < ApplicationController
    before_action :authenticate_user!

    def new


        # setup_intent = Stripe::SetupIntent.create(
        #     {
        #         payment_method_types: ['us_bank_account', 'card'],
        #         attach_to_self: true,
        #     },
        #     {stripe_account: current_user.stripe_account.stripe_id}
        # )
        # @client_secret = setup_intent.client_secret

        # <div id="test_form" data-client-secret="<%=@client_secret%>" data-connect-account="<%=current_user.stripe_account.stripe_id%>">
        # </div>

        # <button id="test_button" class="btn btn-primary btn-lg">Submit!</button>



        @card = Card.new
        @billing_address = @card.build_billing_address
        render :new
    end

    def create
        token = Stripe::Token.create(
            card: {
                number: allowed_params[:number],
                exp_month: allowed_params[:exp_month],
                exp_year: allowed_params[:exp_year],
                cvc: allowed_params[:cvc],
                currency: "usd",
              },
        )
        if token.card.funding != "debit"
            flash[:info] = "That card is not a debit card."

        end
        external_account = Stripe::Account.create_external_account(
            current_user.stripe_account.stripe_id,
            {external_account: token.id}
        )
    end

    def allowed_params
        params.require(:card).permit(
            :authenticity_token,
            :continue_path,
            :number,
            :exp_month,
            :exp_year,
            :cvc,
            address_attributes: [
                :line1,
                :line2,
                :city,
                :state,
                :zip_code,
                :country,
            ]
        )
    end    
end
# ======= Instructions for settlement-intended payment methods

# 1 Create SetupIntent with attach_to_self set to TRUE. Send to client.

# 2 Show payment element. User enters payment details and presses submit button.

# 3 Get webhook event: payment_method.attached
# It will have data you can use to create the SDE-side PaymentMethod record. Most importantly...
#    - stripe account id
#    - payment method id

# 4 User is redirected to page showing status of newly added payment method. 


# ======= Instructions for creating billing-intended payment methods (ONLY WORKS WITH BANK ACCOUNTS)

# 1 Client clicks button request to /secret endpoint. SetupIntent created server-side, and secret sent.

# 2 Client receives secret and uses it to call collectBankAccountToken() JS code.

# 3 User is guided through Stripe Modal. When they are done, a form with the token is submitted to the SDE server.

# 4 Server-side, create the Stripe external account using the client token.


# TAKEAWAY
# External accounts are for billing
# Attached payment methods are for settlements