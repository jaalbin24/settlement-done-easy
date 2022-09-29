class DocumentReviewsController < ApplicationController
    before_action :authenticate_user!, :ensure_user_is_authorized

    def ensure_user_is_authorized

    end

    def reject
        # documents/:id/reject
        begin
            document = Document.find_by!(public_id: params[:id])
            review = document.reviews.with_reviewer(current_user).first
            if review.reject
                if document.will_be_destroyed_after_rejection
                    flash[:info] = "The document was rejected and automatically deleted."
                    redirect_to settlement_show_path(document.settlement)
                    return
                else
                    flash[:info] = "The document was rejected."
                    redirect_to document_show_path(document)
                    return
                end
            else
                flash[:info] = "The document could not be rejected right now. Try again later."
                puts "⚠️⚠️⚠️ ERROR: #{review.errors.full_messages.inspect}"
            end
        rescue ActiveRecord::RecordNotFound => e
            flash[:info] = "The document you tried to reject does not exist."
        rescue => e
            flash[:info] = "An unknown error occured."
        end
        redirect_back(fallback_location: root_path)
    end

    def unreject
        # documents/:id/unreject
        begin
            document = Document.find_by!(public_id: params[:id])
            review = document.reviews.with_reviewer(current_user).first
            if !review.is_for_rejection?
                flash[:info] = "You cannot unreject this document because it has not been rejected."
                redirect_back(fallback_location: root_path)
                return
            end
            if review.unreject
                flash[:info] = "The document was unrejected."
            else
                flash[:info] = "This document could not be unrejected right now. Try again later."
            end
        rescue ActiveRecord::RecordNotFound => e
            flash[:info] = "The document you tried to unreject does not exist."
        rescue => e
            puts "⚠️⚠️⚠️ ERROR: #{e.message}"
            flash[:info] = "An unknown error occured."
        end
        redirect_back(fallback_location: root_path)
    end

    def approve
        # documents/:id/approve
        begin
            document = Document.find_by!(public_id: params[:id])
            review = document.reviews.with_reviewer(current_user).first
            if review.approve
                flash[:info] = "Document approved!"
            else
                flash[:info] = "The document could not be rejected right now. Try again later."
            end
        rescue ActiveRecord::RecordNotFound => e
            flash[:info] = "The document you tried to approve does not exist."
        rescue => e
            puts "⚠️⚠️⚠️ ERROR: #{e.message}"
            flash[:info] = "An unknown error occured."
        end
        redirect_back(fallback_location: root_path)
    end
end
  