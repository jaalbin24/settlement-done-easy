class UserProfileController < ApplicationController
    before_action :authenticate_user!


    def update
        user_profile = UserProfile.find_by(public_id: params[:public_id])
        if user_profile.update(allowed_params)
            flash[:primary] = {
                heading: "Changes saved",
                message: "The changes to your profile were saved."
            }
        else
            flash[:primary] = "Failed to update :("
        end
        if params[:continue_path].blank?
            redirect_to user_profile_show_path(user_profile)
        else
            redirect_to params[:continue_path]
        end
    end

    def edit
        @user_profile = UserProfile.find_by(public_id: params[:public_id])
        @owner = @user_profile.user
        if params[:continue_path].blank?
            @continue_path = user_profile_show_path(@user_profile)
        end
        render :edit      
    end

    def show
        @user_profile = UserProfile.find_by(public_id: params[:public_id])
        @owner = @user_profile.user
        if current_user.isMemberOf?(@owner) || current_user.isMemberOf?(@owner.organization)
            @settlements = Settlement.belonging_to(@owner)
        else
            @settlements = Settlement.belonging_to(@owner).merge(Settlement.belonging_to(current_user))
        end
        
        if @owner.isOrganization? && current_user == @owner 
            @activation_progress = 0
            @activation_progress += 1 if @owner.stripe_account_onboarded?
            @activation_progress += 1 if @owner.has_bank_account?
            @activation_progress += 1 if @owner.has_member_account?
            @activation_progress += 1 if @owner.two_factor_authentication_enabled?
            @activation_progress += 1 if @owner.email_verified?
            @activation_progress = @activation_progress * 100 / 5
        end

        @documents = Document.belonging_to(current_user).order(created_at: :desc)
        @bank_accounts = @owner.bank_accounts

        if params[:section].blank?
            @section = "about"
            @section = "settlements" if @owner == current_user
        else
            @section = params[:section]
        end
        render :show
    end

    protected

    def allowed_params
        params.require(:user_profile).permit(
            :first_name,
            :last_name,
            :phone_number,
            :date_of_birth,
            :relationship_to_business,
            :percent_ownership,
            :last_4_of_ssn,
            :mcc,
            :tax_id,
            :product_description,
            :email,
            address_attributes: [
                :line1,
                :line2,
                :city,
                :state,
                :country,
                :postal_code
            ]
        )
    end
end
