class BankAccountsController < ApplicationController
    before_action :authenticate_user!

    def secret
        if session[:bank_account_setup_intent_id].blank?
            # If there is no setup intent id stored in the session, we will have to create a new SetupIntent by calling the Stripe API.
            setup_intent = create_setup_intent
        elsif session[:bank_account_setup_intent_id]
            # If there is a setup intent id stored in the session, retrieve that to make sure it can still be used to collect
            # bank account info.
            setup_intent = Stripe::SetupIntent.retrieve(
                session[:bank_account_setup_intent_id],
                {stripe_account: current_user.to_organization.stripe_account.stripe_id}
            )
            # Make sure setup intent is still able to collect bank account info.
            if setup_intent.status.in?(["processing", "canceled", "succeeded"])
                setup_intent = create_setup_intent
            end
        end

        # Store the secret in the session whether it's already there or not.
        session[:bank_account_setup_intent_id] = setup_intent.id

        render json: {
            secret: setup_intent.client_secret, 
            stripe_account: current_user.to_organization.stripe_account.stripe_id
        }
    end

    
    def new
        render :new_new
    end

    def create
        begin
            external_account = Stripe::Account.create_external_account(
                current_user.stripe_account.stripe_id,
                {external_account: allowed_params[:token]}
            )
            payment_method = current_user.payment_methods.create!(
                stripe_id: external_account.id,
                type: external_account.object.camelize,
                bank_name: external_account.bank_name,
                country: external_account.country,
                currency: external_account.currency,
                last4: external_account.last4,
                status: external_account.status
            )
            flash[:info] = {
                heading: "New #{payment_method.type.underscore.gsub("_"," ")} added",
                message: "Your #{payment_method.type.underscore.gsub("_"," ")} was added, but it is not yet verified. Two amounts less than $1 were deposited into your new account. Enter those amounts to verify your account."
            }
        rescue => e
            
        end

        @continue_path = root_path if @continue_path.blank?
        redirect_to @continue_path
    end

    private

    def allowed_params
        params.permit(
            :token,
            :authenticity_token,
            :continue_path,
            :country,
            :zip_code
        )
    end

    def create_setup_intent
        Stripe::SetupIntent.create(
            {
                payment_method_types: ['us_bank_account'],
                attach_to_self: true,
                metadata: {
                    added_by: current_user.public_id,
                },
            },
            {stripe_account: current_user.to_organization.stripe_account.stripe_id}
        )
    end
end
