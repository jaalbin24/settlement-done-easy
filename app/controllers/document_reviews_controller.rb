class DocumentReviewsController < ApplicationController
    before_action :authenticate_user!, :ensure_user_is_authorized!

    def ensure_user_is_authorized!
        begin
            document = Document.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
        if !document.can_be_reviewed_by?(current_user)
            flash[:info] = "You are not authorized to review this document."
            redirect_back(fallback_location: root_path)
        end
    end

    def reject
        # documents/:id/reject
        begin
            document = Document.find(params[:id])
            review = document.reviews.authored_by(current_user).first
            if review.reject
                flash[:info] = "Document rejected!"
            else
                flash[:info] = "The document could not be rejected right now. Try again later."
            end
        rescue ActiveRecord::RecordNotFound => e
            flash[:info] = "The document you tried to reject does not exist."
        rescue => e
            puts "⚠️⚠️⚠️ ERROR: #{e.message}"
            flash[:info] = "An unknown error occured."
        end
        redirect_back(fallback_location: root_path)
    end

    def unreject
        # documents/:id/unreject
        begin
            document = Document.find(params[:id])
            review = document.reviews.authored_by(current_user).first
            if !review.is_for_rejection?
                flash[:info] = "You cannot unreject this document because it has not been rejected."
                redirect_back(fallback_location: root_path)
                return
            end
            if review.unreject
                flash[:info] = "Document unrejected!"
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
            document = Document.find(params[:id])
            review = document.reviews.authored_by(current_user).first
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
  