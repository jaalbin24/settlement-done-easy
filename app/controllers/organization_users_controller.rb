class OrganizationUsersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_user_is_organization

    def ensure_user_is_organization
        if current_user != User.find_by!(public_id: params[:org_id])
            flash[:info] = "You are not authorized to access that page."
            redirect_to root_path
        end
    end

    def show
        @organization = User.find_by!(public_id: params[:org_id])
        @stripe_account = Stripe::Account.retrieve(current_user.stripe_account_id)
    end

    def settlements_index
        @organization = User.find_by!(public_id: params[:org_id])
        render :settlements_index
    end

    def members_index
        @organization = User.find_by!(public_id: params[:org_id])
        render :members_index
    end

    def show_member
        @organization = User.find_by!(public_id: params[:org_id])
        @member = User.find_by!(public_id: params[:mem_id])
        render :show_member
    end

    def remove_member
        organization = User.find_by!(public_id: params[:org_id])
        member = User.find_by!(public_id: params[:mem_id])

        organization.members.delete(member)
        flash[:info] = "#{member.full_name} removed!"
        redirect_to members_index_url(organization)
    end

    def new_member
        @organization = User.find_by!(public_id: params[:org_id])
        @member = User.new
        render :new_member
    end

    def create_member
        organization = User.find_by!(public_id: params[:org_id])
        member = organization.members.build(member_params)

        if organization.isLawFirm?
            member.role = "Attorney"
        elsif organization.isInsuranceCompany?
            member.role = "Insurance Agent"
        end
        if member.save
            flash[:info] = "New member #{member.full_name} added!"
        else
            puts "========================== ERROR: OrganizationUsersController.create_member: #{member.errors.full_messages.inspect}"
        end
        redirect_to organization_show_member_url(organization, member)
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
