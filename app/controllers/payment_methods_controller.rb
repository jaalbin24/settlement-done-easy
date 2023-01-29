class PaymentMethodsController < ApplicationController
    before_action :authenticate_user!

    def new
        render :new_bank_account
    end

    def new_card
        setup_intent = Stripe::SetupIntent.create(
            {
                payment_method_types: ["card"],
                payment_method_options: {

                },
                # attach_to_self: true,
                # on_behalf_of: current_user.stripe_account.stripe_id,
                # flow_directions: ["inbound", "outbound"],
            },
            # {stripe_account: current_user.stripe_account.stripe_id}
        )
        @secret = setup_intent.client_secret
        @stripe_account = current_user.stripe_account.stripe_id
        render :new_card
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

    def allowed_params
        params.permit(
            :token,
            :authenticity_token,
            :continue_path
        )
    end
end
