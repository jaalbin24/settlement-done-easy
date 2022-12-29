class UserProfileController < ApplicationController
    before_action :authenticate_user!


    def update
        user_profile = User.find_by(public_id: params[:id]).profile
        if user_profile.update(allowed_params)
            flash[:primary] = "Updated!"
        else
            flash[:primary] = "Failed to update :("
        end
        redirect_to profile_settings_path
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
