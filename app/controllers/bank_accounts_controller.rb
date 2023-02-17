class BankAccountsController < ApplicationController
    before_action :authenticate_user!

    def secret
        local_setup_intent = current_user.setup_intents.for(:bank_account).needs_action.first
        if local_setup_intent.nil?
            remote_setup_intent = create_setup_intent
            local_setup_intent = current_user.setup_intents.create!(
                payment_method_type:    "BankAccount",
                stripe_id:              remote_setup_intent.id,
                client_secret:          remote_setup_intent.client_secret,
                status:                 remote_setup_intent.status,
                stripe_account_id:      current_user.to_organization.stripe_account.stripe_id
            )
        end

        render json: {
            secret: local_setup_intent.client_secret,
            stripe_account: local_setup_intent.stripe_account_id,
        }
    end

    def new
        render :new
    end

    def after_create
        #flash[:primary] = FlashMessages::BankAccountMessage.for(params[:redirect_status])
        case params[:redirect_status].to_sym
        when :succeeded
            @title = "Your bank account was added successfully!"
            @body = "You will be redirected to the bank accounts section in 5 seconds."
        end
        render :after_create
        setup_intent = StripeSetupIntent.find_by(stripe_id: params[:setup_intent])
        setup_intent.update(
            status: params[:redirect_status],
        )
    end

    def update
        bank_account = BankAccount.find_by(public_id: params[:public_id])
        bank_account.update(allowed_params)
        flash[:primary] = "Your bank account was updated."
        redirect_to @continue_path.blank? ? root_path : @continue_path
    end

    def delete
        begin
            bank_account = current_user.bank_accounts.find_by!(public_id: params[:public_id])
        rescue => e
            flash[:danger] = FlashMessages::ErrorMessage.for(e)
            redirect_to @continue_path.blank? ? root_path : @continue_path
            return
        end

        if bank_account.destroy
            flash[:primary] = "Your bank account was deleted."
        else
            flash[:danger] = "There was an error deleting your bank account."
        end
        redirect_to @continue_path.blank? ? root_path : @continue_path
    end

    private

    def allowed_params
        params.require(:bank_account).permit(
            :nickname
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
