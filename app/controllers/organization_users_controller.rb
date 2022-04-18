class OrganizationUsersController < ApplicationController
    def settlements_index
        @organization = User.find(params[:id])
        render :settlements_index
    end

    def members_index

    end

    def show_member_info
  
    end
end
