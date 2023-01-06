class UserProfileSettingsController < ApplicationController
    before_action :authenticate_user!


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
            :show_tax_id_to_public,
            :show_tax_id_to_members_only,
      
            :show_product_description_to_public,
            :show_product_description_to_members_only,
      
            :show_mcc_to_public,
            :show_mcc_to_members_only,
      
            :show_last_name_to_public,
            :show_last_name_to_members_only,
      
            :show_phone_number_to_public,
            :show_phone_number_to_members_only,
      
            :show_email_to_public,
            :show_email_to_members_only,
      
            :show_address_to_public,
            :show_address_to_members_only,
      
            :show_date_of_birth_to_public,
            :show_date_of_birth_to_members_only,

            :show_relationship_to_business_to_public,
            :show_relationship_to_business_to_members_only,

            :show_percent_ownership_to_public,
            :show_percent_ownership_to_members_only,

            :show_last_4_of_ssn_to_public,
            :show_last_4_of_ssn_to_members_only,

            :show_legal_name_to_public,
            :show_legal_name_to_members_only,
        )
    end
end
