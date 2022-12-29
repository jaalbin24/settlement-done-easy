class PaymentRequestsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_user_is_accepter, only: [:accept, :deny]

    def ensure_user_is_accepter
        payment_request = PaymentRequest.find_by!(public_id: params[:id])
        if payment_request.accepter != current_user
            flash[:primary] = "You are not authorized to accept or deny that request."
            redirect_back(fallback_location: root_path)
        end
    end

    def create
        # POST settlement/:id/payment_request
        settlement = Settlement.find_by!(public_id: params[:id])
        begin
            settlement.payment_requests.create!(
                requester:  settlement.attorney,
                accepter:   settlement.adjuster
            )
            flash[:primary] = "Payment requested"
        rescue SafetyError::SafetyError => e
            flash[:primary] = e.message
        rescue => e
            flash[:primary] = "Payment not requested. Please try again later."
            puts "⚠️⚠️⚠️ ERROR: #{e.message}"
        end
        redirect_back(fallback_location: root_path)
    end

    def deny
        # POST payment_request/:id/deny
        payment_request = PaymentRequest.find_by!(public_id: params[:id])
        if payment_request.deny
            flash[:primary] = "Payment request denied!"
        else
            flash[:primary] = "Payment request could not be denied at this time. Try again later."
            puts "⚠️⚠️⚠️ ERROR: #{payment_request.errors.full_messages.inspect}"
        end
        redirect_back(fallback_location: root_path)
    end

    def accept
        # POST payment_request/:id/accept
        payment_request = PaymentRequest.find_by!(public_id: params[:id])
        if payment_request.accept
            flash[:primary] = "Payment request accepted!"
        else
            flash[:primary] = "Payment request could not be accepted at this time. Try again later."
            puts "⚠️⚠️⚠️ ERROR: #{payment_request.errors.full_messages.inspect}"
        end
        redirect_back(fallback_location: root_path)
    end
end
