class OrganizationUsersController < ApplicationController
    before_action :authenticate_user!

    def settlements_index
        @organization = User.find(params[:id])
        render :settlements_index
    end

    def members_index
        @organization = User.find(params[:id])
        render :members_index
    end

    def show_member
        @member = User.find(params[:mem_id])
        render :show_member
    end

    def remove_member
        organization = User.find(params[:org_id])
        member = User.find(params[:mem_id])

        organization.organization_members.delete(member)
        flash[:info] = "#{member.full_name} removed!"
        redirect_to organization_members_index_url(organization)
    end


    def add_member
        organization = User.find(params[:org_id])
        member = User.find(params[:mem_id])

        member.organization = organization
        if !member.save
            puts "========================== OrganizationUsersController.add_member: #{member.errors.full_messages.inspect}"
        end
        redirect_to organization_show_member_url
    end
end
