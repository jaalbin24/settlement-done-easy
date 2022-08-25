class PaymentRequestsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_user_is_accepter, only: [:accept, :deny]

    def ensure_user_is_accepter
        payment_request = PaymentRequest.find(params[:id])
        if payment_request.accepter != current_user
            flash[:info] = "You are not authorized to accept or deny that request."
            redirect_back(fallback_location: root_path)
        end
    end

    def create
        # POST settlement/:id/payment_request
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

    def deny
        # POST payment_request/:id/deny
        payment_request = PaymentRequest.find(params[:id])
        if payment_request.deny
            flash[:info] = "Payment request denied!"
        else
            flash[:info] = "Payment request could not be denied at this time. Try again later."
            puts "⚠️⚠️⚠️ ERROR: #{payment_request.errors.full_messages.inspect}"
        end
        redirect_back(fallback_location: root_path)
    end

    def accept
        # POST payment_request/:id/accept
        payment_request = PaymentRequest.find(params[:id])
        if payment_request.accept
            flash[:info] = "Payment request accepted!"
        else
            flash[:info] = "Payment request could not be accepted at this time. Try again later."
            puts "⚠️⚠️⚠️ ERROR: #{payment_request.errors.full_messages.inspect}"
        end
        redirect_back(fallback_location: root_path)
    end
end
