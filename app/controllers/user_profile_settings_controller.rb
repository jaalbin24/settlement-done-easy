class UserProfileSettingsController < ApplicationController
    def update
        user_profile_settings = current_user.settings.profile
        if user_profile_settings.update(allowed_params)
            flash[:primary] = "Settings updated!"
        else
            flash[:warning] = "Settings not updated!"
        end
        redirect_to profile_settings_path
    end


    protected


    def allowed_params
        params.require(:user_profile_settings).permit(
            :hide_tax_id_from_public,
            :hide_tax_id_from_members,
      
            :hide_product_description_from_public,
            :hide_product_description_from_members,
      
            :hide_mcc_from_public,
            :hide_mcc_from_members,
      
            :hide_last_name_from_public,
            :hide_last_name_from_members,
      
            :hide_phone_number_from_public,
            :hide_phone_number_from_members,
      
            :hide_email_from_public,
            :hide_email_from_members,
      
            :hide_address_from_public,
            :hide_address_from_members,
      
            :hide_date_of_birth_from_public,
            :hide_relationship_to_business_from_public,
            :hide_percent_ownership_from_public,
            :hide_last_4_of_ssn_from_public,
        )
    end
end
