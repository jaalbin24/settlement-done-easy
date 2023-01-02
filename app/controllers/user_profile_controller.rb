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
        @user = @user_profile.user
        if params[:continue_path].blank?
            @continue_path = user_profile_show_path(@user_profile)
        else
            @continue_path = params[:continue_path]
        end
        render :edit      
    end

    def show
        @user_profile = UserProfile.find_by(public_id: params[:public_id])
        @user = @user_profile.user
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
            :ssn_last_4,
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
