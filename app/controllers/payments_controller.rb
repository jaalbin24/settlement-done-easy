class PaymentsController < ApplicationController
    before_action :authenticate_user!, :ensure_user_is_authorized

    def ensure_user_is_authorized
        payment = Payment.find_by!(public_id: params[:id])

        unless current_user.can_access?(payment)
            flash[:info] = "You are not authorized to access that payment."
            redirect_back(fallback_location: root_path)
        end
    end

    def update
        payment = Payment.find_by!(public_id: params[:id])
        if !payment_params[:source_id].blank?
            source = BankAccount.find_by!(public_id: payment_params[:source_id])
            flash_message = "Source bank account updated."
        else
            source = payment.source
        end
        if !payment_params[:destination_id].blank?
            destination = BankAccount.find_by!(public_id: payment_params[:destination_id])
            flash_message = "Destination bank account updated."
        else
            destination = payment.destination
        end
        if payment.update(source: source, destination: destination)
            flash[:info] = flash_message
        else
            flash[:info] = "Payment data could not be updated. Try again later."
        end
        redirect_back(fallback_location: root_path)
    end

    def show
        @payment = Payment.find_by!(public_id: params[:id])
        @settlement = @payment.settlement
    end

    def index
        @payments = current_user.payments
    end

    def sync_with_stripe
        payment = Payment.find_by!(public_id: params[:id])
        payment.sync_with_stripe
        redirect_back(fallback_location: root_path)
    end

    def execute
        begin
            payment = Payment.find_by!(public_id: params[:id])
            settlement = payment.settlement
        rescue
            handle_invalid_request
            return
        end

        begin
            settlement.initiate_payment
            flash[:info] = "Payment started!"
        rescue SafetyError::SafetyError => e
            flash[:info] = e.message
        end
        redirect_back(fallback_location: root_path)
    end

    def payment_params
        params.require(:payment).permit(
            :source_id,         #TODO: Remove this line once views/payments/show is removed <------------
            :destination_id,    #TODO: Remove this line once views/payments/show is removed <------------
        )
    end
end
