class BankAccountsController < ApplicationController
    before_action :authenticate_user!
    
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
            {stripe_account: current_user.stripe_account_id}
        )
        response = {
            client_secret: setup_intent.client_secret,
            connect_account_id: current_user.stripe_account_id,
        }.to_json
        render :json => response
    end

    def destroy
        bank_account = BankAccount.find_by!(public_id: params[:id])
        if bank_account.user.bank_accounts.size == 1
            flash[:primary] = "You must keep at least one bank account. Add another bank account to delete this one."
            redirect_back(fallback_location: root_path)
            return
        elsif bank_account.has_processing_payments?
            flash[:primary] = "You cannot delete a bank account with ongoing payments. Wait for this account's payments to settle before deleting."
            redirect_back(fallback_location: root_path)
            return
        else
            begin
                bank_account.destroy
            rescue Stripe::RateLimitError => e
                flash[:primary] = "Account XXXXX#{bank_account.last4} was not deleted due to high network traffic. Try again in a moment."
            rescue Stripe::InvalidRequestError => e
                flash[:primary] = "Account XXXXX#{bank_account.last4} was not deleted due to an invalid request."
            rescue Stripe::AuthenticationError => e
                flash[:primary] = "Account XXXXX#{bank_account.last4} was not deleted due to an authentication error."
            rescue Stripe::APIConnectionError => e
                flash[:primary] = "Account XXXXX#{bank_account.last4} was not deleted due to poor network connectivity. Try again in a moment."
            rescue  => e
                puts "⚠️⚠️⚠️ ERROR: #{e.message}"
                flash[:primary] = "Account XXXXX#{bank_account.last4} could not be deleted."
            end
            if bank_account.persisted?
                flash[:primary] = "Account XXXXX#{bank_account.last4} could not be deleted."
                redirect_back(fallback_location: root_path)
            else
                flash[:primary] = "Account deleted."
                redirect_back(fallback_location: root_path)
            end
        end
    end
end

