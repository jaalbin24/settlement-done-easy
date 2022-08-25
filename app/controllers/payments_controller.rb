class PaymentsController < ApplicationController
    before_action :authenticate_user!

    def create

    end

    def update
        payment = Settlement.find(params[:id]).payment
        if payment.update(payment_params)
            flash[:info] = "Payment data updated."
        else
            flash[:info] = "Payment data could not be updated. Try again later."
        end
        redirect_back(fallback_location: root_path)
    end

    def show
        @settlement = Settlement.find(params[:id])
        @payment = @settlement.active_payment
    end

    def index
        @payments = current_user.payments
    end

    def sync_with_stripe
        payment = Payment.find(params[:id])
        payment.sync_with_stripe
        redirect_back(fallback_location: root_path)
    end

    def payment_params
        params.require(:payment).permit(
            :source_id,
            :destination_id
        )
    end
end
