class CardsController < ApplicationController
    before_action :authenticate_user!

    def new
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

        Stripe::Account.create_external_account(
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