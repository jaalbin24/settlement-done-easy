class BankAccountsController < ApplicationController
    before_action :authenticate_user!

    def secret
        if session[:bank_account_setup_intent_id].blank?
            # If there is no setup intent id stored in the session, we will have to create a new SetupIntent by calling the Stripe API.
            setup_intent = create_setup_intent
        elsif session[:bank_account_setup_intent_id]
            # If there is a setup intent id stored in the session, retrieve that to make sure it can still be used to collect
            # bank account info.
            setup_intent = retrieve_setup_intent(session[:bank_account_setup_intent_id])
            # Make sure setup intent is still able to collect bank account info.
            if setup_intent.status.in?(["processing", "canceled", "succeeded"])
                setup_intent = create_setup_intent
            end
        end

        # Store the secret in the session whether it's already there or not.
        session[:bank_account_setup_intent_id] = setup_intent.id

        render json: {
            secret: setup_intent.client_secret,
            stripe_account: current_user.to_organization.stripe_account.stripe_id,
            continue_url: bank_account_after_create_url,
        }
    end

    
    def new
        @continue_path ||= bank_account_after_create_path()
        render :new_new
    end

    def after_create
        flash[:primary] = FlashMessages::BankAccountMessage.for(params[:redirect_status])

        redirect_to user_profile_show_path(current_user.profile, section: "bank_accounts")
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

    def retrieve_setup_intent(id)
        Stripe::SetupIntent.retrieve(
            id,
            {stripe_account: current_user.to_organization.stripe_account.stripe_id}
        )
    end
end
