class CardsController < ApplicationController
    before_action :authenticate_user!

    # Called by client-side JS
    def secret
        if session[:card_setup_intent_secret].blank?
            # If there is no secret stored in the session, we will have to create a new SetupIntent by calling the Stripe API.
            secret = create_setup_intent.client_secret
        elsif session[:card_setup_intent_secret]
            # If there is a secret stored in the session, send that.
            secret = session[:card_setup_intent_secret]
        end
        session[:card_setup_intent_secret] = secret

        render json: {
            secret: secret, 
            stripe_account: current_user.stripe_account.stripe_id
        }
    end

    def new
        @card = Card.new
        @billing_address = @card.build_billing_address
        render :new
    end

    def create
        if allowed_params[:token].blank?
            flash[:info] = "It failed because the token param was blank!"
            redirect_to card_new_path(continue_path: allowed_params[:continue_path])
            return
        end
        begin
            external_account = Stripe::Account.create_external_account(
                current_user.stripe_account.stripe_id,
                {external_account: allowed_params[:token]}
            )
            billing_address = Address.new(
                line1:          external_account.address_line1,
                line2:          external_account.address_line2,
                city:           external_account.address_city,
                state:          external_account.address_state,
                postal_code:    external_account.address_zip,
                country:        external_account.address_country,
            )
            card = current_user.payment_methods.build(
                type:       external_account.object.camelize,
                stripe_id:  external_account.id,
                last4:      external_account.last4,
                bank_name:  external_account.brand,
                exp_month:  external_account.exp_month,
                exp_year:   external_account.exp_year,
                currency:   external_account.currency,
                status:     external_account.status,
                added_by:   current_user,
                billing_address: billing_address
            )
            card.save!
            flash[:info] = "Your new card was validated."
            if allowed_params[:continue_path].blank?
                redirect_to root_path
            else
                redirect_to allowed_params[:continue_path]
            end
        rescue Stripe::InvalidRequestError => e
            flash[:danger] = ErrorHandler::FlashMessage.for(e)
            redirect_to card_new_path(continue_path: allowed_params[:continue_path])
        end
        
    end

    private

    def allowed_params
        params.require(:card).permit(
            :continue_path,
            :token,
        )
    end

    def create_setup_intent
        Stripe::SetupIntent.create(
            {
                payment_method_types: ['card'],
            },
            {stripe_account: current_user.stripe_account.stripe_id}
        )
    end
end
# ======= Instructions for settlement-intended payment methods

# 1 Create SetupIntent with attach_to_self set to TRUE. Send to client.

# 2 Show payment element. User enters payment details and presses submit button.

# 3 Get webhook event: payment_method.attached
# It will have data you can use to create the SDE-side PaymentMethod record. Most importantly...
#    - stripe account id
#    - payment method id

# 4 User is redirected to page showing status of newly added payment method.

# 5 When time comes to initiate settlement payment (inbound transfer)

    # Stripe::Treasury::InboundTransfer.create({
    #     financial_account: 'fa_1MXSROLjpnfKvSk6koNbT30c',
    #     amount: 10000,
    #     currency: 'usd',
    #     origin_payment_method: 'pm_1KMDdkGPnV27VyGeAgGz8bsi',
    #     description: 'InboundTransfer from my bank account',
    # })


# ======= Instructions for creating billing-intended payment methods

# 1 Client clicks button which sends request to /secret endpoint. SetupIntent created server-side, and secret sent.

# 2 Client receives secret and uses it to call collectBankAccountToken() JS code.

# 3 User is guided through Stripe Modal. When they are done, a form with the token is submitted to the SDE server.

# 4 Server-side, create the Stripe external account using the client token.
# NOTE: The newly added account will become the default for all future charges. Provide a path for the user to change which payment gets charged.

# 5 When the time comes to bill the user for using SDE, create a charge object...

    # Stripe::Charge.create({
    #     amount: 500 * n_settlements,
    #     currency: 'usd',
    #     source: acct_nl49fnnmHf22AP1,
    #     description: 'Settlement Done Easy services',
    # })

# 6

# TAKEAWAY
# External accounts are for billing


# Attached payment methods are for settlements



# HOW DO YOU DELETE ATTACHED PAYMENT METHODS????