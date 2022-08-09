class PagesController < ApplicationController
    before_action :authenticate_user!, except: [:user_type_select, :root]

    def user_type_select
        render :user_type_select
    end

    def generate_or_upload
        render :generate_or_upload
    end

    def approve_or_reject
        @document = Document.find(params[:id])
        @comment = Comment.new
        render :approve_or_reject
    end

    def root
        if !user_signed_in?
            render :home
        elsif current_user.isOrganization?
            render :organization_dashboard
        elsif current_user.isMember?
            render :member_dashboard
        else
            render :home
        end
    end

    def testing
        render :testing
    end
end
