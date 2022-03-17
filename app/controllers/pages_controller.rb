class PagesController < ApplicationController

    def home
        render :home
    end

    def user_type_select
        render :user_type_select
    end

    def generate_or_upload
        render :generate_or_upload
    end

end
