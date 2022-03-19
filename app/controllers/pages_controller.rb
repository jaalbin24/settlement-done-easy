class PagesController < ApplicationController
    before_action :authenticate_user!, except: [:home, :user_type_select]

    def home
        render :home
    end

    def user_type_select
        render :user_type_select
    end

    def generate_or_upload
        render :generate_or_upload
    end

    def approve_or_reject
        @release_form = ReleaseForm.find(params[:id])
        @comment = Comment.new
        render :approve_or_reject
    end
end
