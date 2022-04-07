class PagesController < ApplicationController
    before_action :authenticate_user!, except: :user_type_select

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

    def testing
        render :testing
    end
end
