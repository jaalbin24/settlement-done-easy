class PaymentRequestsController < ApplicationController
    before_action :authenticate_user!
    def create
        settlement = Settlement.find(params[:id])
        if settlement.has_unanswered_payment_request?
            flash[:info] = "Payment has already been requested."
        else
            payment_request = settlement.payment_requests.build(
                requester: current_user
            )
            if payment_request.save
                flash[:info] = "Payment requested."
            else
                flash[:info] = "Payment request failed."
                puts "⚠️⚠️⚠️ ERROR: #{payment_request.errors.full_messages.inspect}"
            end
        end
        redirect_back(fallback_location: root_path)
    end

    def update
        settlement = Settlement.find(params[:id])
        payment_request = settlement.active_payment_request
        payment_request.update()
    end

    def payment_request_params
        params.require(:payment_request).permit(
            :status
        )
    end
end
