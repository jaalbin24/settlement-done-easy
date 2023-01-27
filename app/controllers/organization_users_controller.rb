class OrganizationUsersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_user_is_organization

    def ensure_user_is_organization
        unless current_user.isOrganization?
            flash[:primary] = "You are not authorized to access that page."
            redirect_to root_path
        end
    end

    def show
        @organization = current_user
        @stripe_account = Stripe::Account.retrieve(current_user.stripe_account_id)
    end

    def settlements_index
        @organization = current_user
        render :settlements_index
    end

    def members_index
        @organization = current_user
        render :members_index
    end

    def show_member
        @organization = current_user
        @member = User.find_by!(public_id: params[:mem_id])
        render :show_member
    end

    def remove_member
        organization = current_user
        member = User.find_by!(public_id: params[:mem_id])

        organization.members.delete(member)
        flash[:primary] = "#{member.name} removed!"
        redirect_to members_index_url(organization)
    end

    def new_member
        @organization = current_user
        @member = User.new
        @profile = @member.build_profile
        render :new_member
    end

    def create_member
        organization = current_user
        member = organization.members.build(member_params)

        if organization.isLawFirm?
            member.role = "Attorney"
        elsif organization.isInsuranceCompany?
            member.role = "Adjuster"
        end
        if member.save
            flash[:primary] = "New member #{member.name} added!"
        else
            puts "========================== ERROR: OrganizationUsersController.create_member: #{member.errors.full_messages.inspect}"
        end
        redirect_to user_profile_show_path(member.profile)
    end

    def member_params
        params.require(:user).permit(
            :first_name,
            :last_name,
            :email,
            :password,
            :password_confirmation,
            profile_attributes: [
                :first_name,
                :last_name
            ]
        )
    end
end
