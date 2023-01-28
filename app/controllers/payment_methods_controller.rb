class PaymentMethodsController < ApplicationController
    before_action :authenticate_user!

    def new
        setup_intent = Stripe::SetupIntent.create(
            {
                payment_method_types: ["us_bank_account"],
                payment_method_options: {
                    us_bank_account: {
                        financial_connections: {permissions: ["payment_method", "balances"]},
                    },
                },
                attach_to_self: true,
                flow_directions: ["inbound", "outbound"],
            },
            {stripe_account: current_user.stripe_account.stripe_id}
        )
        @secret = setup_intent.client_secret
        @stripe_account = current_user.stripe_account.stripe_id
        @continue_path = root_path if @continue_path.blank?
        @payment_method = PaymentMethod.new
        render :new
    end

    # Called by client-side javascript
    def secret
        setup_intent = Stripe::SetupIntent.create(
            {
                payment_method_types: ["us_bank_account"],
                payment_method_options: {
                    us_bank_account: {
                        financial_connections: {permissions: ["payment_method", "balances"]},
                    },
                },
                attach_to_self: true,
                flow_directions: ["inbound", "outbound"],
            },
            {stripe_account: current_user.stripe_account.stripe_id}
        )
        response = {
            client_secret: setup_intent.client_secret,
            connect_account_id: current_user.stripe_account.stripe_id,
        }.to_json
        render :json => response
    end
end
