class DocumentReviewsController < ApplicationController
    before_action :authenticate_user!, :ensure_user_is_authorized

    def ensure_user_is_authorized

    end

    def reject
        # documents/:id/reject
        begin
            document = Document.find_by!(public_id: params[:id])
            review = document.reviews.by(current_user).first
            if review.reject && !document.nil?
                # if document.will_be_deleted_after_rejection? || document.nil?
                #     flash[:primary] = "The document was rejected and automatically deleted."
                #     redirect_to settlement_show_path(document.settlement)
                #     return
                # else
                #     flash[:primary] = "The document was rejected."
                #     redirect_to document_show_path(document)
                #     return
                # end
            else
                flash[:primary] = "The document could not be rejected right now. Try again later."
                puts "⚠️⚠️⚠️ ERROR: #{review.errors.full_messages.inspect}"
                redirect_back(fallback_location: root_path)
            end
        rescue ActiveRecord::RecordNotFound => e
            flash[:primary] = "The document you tried to reject does not exist."
            puts "⚠️⚠️⚠️ Error: #{e.message}"
            puts "⚠️⚠️⚠️ Backtrace: #{e.backtrace}"
        rescue => e
            flash[:primary] = "An unknown error occured."
            puts "⚠️⚠️⚠️ Error: #{e.message}"
            puts "⚠️⚠️⚠️ Backtrace: #{e.backtrace}"
        end
        redirect_to root_path
    end

    def unreject
        # documents/:id/unreject
        begin
            document = Document.find_by!(public_id: params[:id])
            review = document.reviews.by(current_user).first
            if !review.is_for_rejection?
                flash[:primary] = "You cannot unreject this document because it has not been rejected."
                redirect_back(fallback_location: root_path)
                return
            end
            if review.unreject
                flash[:primary] = "The document was unrejected."
            else
                flash[:primary] = "This document could not be unrejected right now. Try again later."
            end
        rescue ActiveRecord::RecordNotFound => e
            flash[:primary] = "The document you tried to unreject does not exist."
        rescue => e
            puts "⚠️⚠️⚠️ ERROR: #{e.message}"
            flash[:primary] = "An unknown error occured."
        end
        redirect_back(fallback_location: root_path)
    end

    def approve
        # documents/:id/approve
        begin
            document = Document.find_by!(public_id: params[:id])
            review = document.reviews.by(current_user).first
            if review.approve
                flash[:primary] = "Document approved!"
            else
                flash[:primary] = "The document could not be rejected right now. Try again later."
            end
        rescue ActiveRecord::RecordNotFound => e
            flash[:primary] = "The document you tried to approve does not exist."
        rescue => e
            puts "⚠️⚠️⚠️ ERROR: #{e.message}"
            flash[:primary] = "An unknown error occured."
        end
        redirect_back(fallback_location: root_path)
    end
end
  