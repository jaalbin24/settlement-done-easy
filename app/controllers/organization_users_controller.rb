class OrganizationUsersController < ApplicationController
    before_action :authenticate_user!

    def settlements_index
        @organization = User.find(params[:org_id])
        render :settlements_index
    end

    def members_index
        @organization = User.find(params[:org_id])
        render :members_index
    end

    def show_member
        @organization = User.find(params[:org_id])
        @member = User.find(params[:mem_id])
        render :show_member
    end

    def remove_member
        organization = User.find(params[:org_id])
        member = User.find(params[:mem_id])

        organization.members.delete(member)
        flash[:info] = "#{member.full_name} removed!"
        redirect_to members_index_url(organization)
    end

    def new_member
        @organization = User.find(params[:org_id])
        @member = User.new
        render :new_member
    end

    def create_member
        organization = User.find(params[:org_id])
        member = organization.members.build(member_params)

        if organization.isLawFirm?
            member.role = "Attorney"
        elsif organization.isInsuranceCompany?
            member.role = "Insurance Agent"
        end
        if !member.save
            puts "========================== ERROR: OrganizationUsersController.create_member: #{member.errors.full_messages.inspect}"
        end
        redirect_to organization_show_member_url(organization, member)
    end

    def join
        if current_user.isAttorney?
            @organizations = User.all_law_firms
        elsif current_user.isInsuranceAgent?
            @organizations = User.all_insurance_companies
        else
            handle_invalid_request
            return
        end
        render :join
    end

    def member_params
        params.require(:user).permit(
            :first_name,
            :last_name,
            :email,
            :password,
            :password_confirmation
        )
    end
end
