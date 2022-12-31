class UserProfileController < ApplicationController
    before_action :authenticate_user!


    def update
        user_profile = User.find_by(public_id: params[:id]).profile
        if user_profile.update(allowed_params)
            flash[:primary] = {
                heading: "Changes saved",
                message: "The changes to your profile were saved."
            }
        else
            flash[:primary] = "Failed to update :("
        end
        redirect_to user_profile_edit_url
    end

    def edit
        @user_profile = current_user.profile
        render :edit
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
