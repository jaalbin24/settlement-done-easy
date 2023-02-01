class CardsController < ApplicationController
    before_action :authenticate_user!

    def new
        @public_key = "EXAMPLE"
        setup_intent = Stripe::SetupIntent.create(
            payment_method_types: ["card"],
        )
        @secret = setup_intent.client_secret
        @stripe_account = current_user.stripe_account.stripe_id
        render :new
    end

    def create
        puts "==========================> token=#{params[:stripe_token]} <=========================="
        Stripe::Account.create_external_account(
            current_user.stripe_account.stripe_id,
            {external_account: allowed_params[:stripe_token]}
        )
    end

    def allowed_params
        params.permit(
            :stripe_token,
            :authenticity_token,
            :continue_path,
            :country,
            :zip_code
        )
    end    
end