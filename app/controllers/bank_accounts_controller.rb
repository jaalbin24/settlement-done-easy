class BankAccountsController < ApplicationController
    before_action :authenticate_user!
    
    def new
        fin_conn_session = Stripe::FinancialConnections::Session.create({
            account_holder: {type: 'account', account: current_user.stripe_account_id},
            filters: {countries: ['US']},
            permissions: ['ownership', 'payment_method'],
        })
        @client_secret = fin_conn_session.client_secret
        # @setup_intent = Stripe::SetupIntent.create(
        #     customer: "cus_MAhXz9LDZ7xCQq",
        #     payment_method_types: ["us_bank_account"],
        #     payment_method_options: {
        #         us_bank_account: {
        #             financial_connections: {permissions: ['payment_method', 'balances']}
        #         }
        #     }
        # )
        render :new
    end

    def create

    end

    def destroy

    end
end