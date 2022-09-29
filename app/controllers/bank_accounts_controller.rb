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

    def create
        # If params include token, account_num, and client_secret
        # If user has onboarded stripe account
        if params[:bank_token].blank? || params[:client_secret].blank?
            head 400
            return        
        end

        bank_token = params[:bank_token]
        client_secret = params[:client_secret]
        
        external_account = Stripe::Account.create_external_account(
            current_user.stripe_account_id,
            {external_account: bank_token}
        )

        bank_account = current_user.bank_accounts.build(
            stripe_payment_method_id: external_account.id,
            nickname: external_account.bank_name,
            last4: external_account.last4,
            status: external_account.status
        )

        if bank_account.save
            flash[:info] = "Account #{bank_account.nickname} added!"
            head 201
        else
            flash[:info] = "There was a server error adding that account."
            head 500
        end
    end

    def destroy
        bank_account = BankAccount.find_by!(public_id: params[:id])
        if bank_account.user.bank_accounts.size == 1
            flash[:info] = "You must keep at least one bank account. Add another bank account to delete this one."
            redirect_back(fallback_location: root_path)
            return
        elsif bank_account.has_processing_payments?
            flash[:info] = "You cannot delete a bank account with ongoing payments. Wait for this account's payments to settle before deleting."
            redirect_back(fallback_location: root_path)
            return
        else
            begin
                bank_account.destroy
            rescue Stripe::RateLimitError => e
                flash[:info] = "Account XXXXX#{bank_account.last4} was not deleted due to high network traffic. Try again in a moment."
            rescue Stripe::InvalidRequestError => e
                flash[:info] = "Account XXXXX#{bank_account.last4} was not deleted due to an invalid request."
            rescue Stripe::AuthenticationError => e
                flash[:info] = "Account XXXXX#{bank_account.last4} was not deleted due to an authentication error."
            rescue Stripe::APIConnectionError => e
                flash[:info] = "Account XXXXX#{bank_account.last4} was not deleted due to poor network connectivity. Try again in a moment."
            rescue  => e
                puts "⚠️⚠️⚠️ ERROR: #{e.message}"
                flash[:info] = "Account XXXXX#{bank_account.last4} could not be deleted."
            end
            if bank_account.persisted?
                flash[:info] = "Account XXXXX#{bank_account.last4} could not be deleted."
                redirect_back(fallback_location: root_path)
            else
                flash[:info] = "Account deleted."
                redirect_back(fallback_location: root_path)
            end
        end
    end
end

