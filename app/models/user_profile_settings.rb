# == Schema Information
#
# Table name: user_profile_settings
#
#  id                                            :bigint           not null, primary key
#  show_address_to_members_only                  :boolean
#  show_address_to_public                        :boolean
#  show_date_of_birth_to_members_only            :boolean
#  show_date_of_birth_to_public                  :boolean
#  show_email_to_members_only                    :boolean
#  show_email_to_public                          :boolean
#  show_last_4_of_ssn_to_members_only            :boolean
#  show_last_4_of_ssn_to_public                  :boolean
#  show_last_name_to_members_only                :boolean
#  show_last_name_to_public                      :boolean
#  show_legal_name_to_members_only               :boolean
#  show_legal_name_to_public                     :boolean
#  show_mcc_to_members_only                      :boolean
#  show_mcc_to_public                            :boolean
#  show_percent_ownership_to_members_only        :boolean
#  show_percent_ownership_to_public              :boolean
#  show_phone_number_to_members_only             :boolean
#  show_phone_number_to_public                   :boolean
#  show_product_description_to_members_only      :boolean
#  show_product_description_to_public            :boolean
#  show_relationship_to_business_to_members_only :boolean
#  show_relationship_to_business_to_public       :boolean
#  show_tax_id_to_members_only                   :boolean
#  show_tax_id_to_public                         :boolean
#  created_at                                    :datetime         not null
#  updated_at                                    :datetime         not null
#  public_id                                     :string
#  user_settings_id                              :bigint
#
# Indexes
#
#  index_user_profile_settings_on_user_settings_id  (user_settings_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_settings_id => user_settings.id)
#
class UserProfileSettings < ApplicationRecord
    belongs_to(
        :user_settings,
        class_name: "UserSettings",
        foreign_key: :user_settings_id,
        inverse_of: :profile
    )

    validates :show_last_4_of_ssn_to_members_only,   inclusion: {in: [false]}
    validates :show_last_4_of_ssn_to_public,         inclusion: {in: [false]}

    before_validation do
        puts "❤️❤️❤️ UserProfileSettings before_validation block"
        self.attributes.each do |attr_name, attr_value|
            if attr_name.include? "_to_public"
                profile_attr = attr_name.sub("show_", "").sub("_to_public", "")
                if attr_value
                    self.write_attribute("show_#{profile_attr}_to_members_only".to_sym, false)
                end
            elsif attr_name.include? "_to_members_only"
                profile_attr = attr_name.sub("show_", "").sub("_to_members_only", "")
                if attr_value
                    self.write_attribute("show_#{profile_attr}_to_public".to_sym, false)
                end
            end
        end
    end

    def self.default_settings_for_user(user)
        if user.isOrganization?
            {
                show_tax_id_to_public:                          false,
                show_tax_id_to_members_only:                    false,
          
                show_product_description_to_public:             true,
                show_product_description_to_members_only:       false,
          
                show_mcc_to_public:                             true,
                show_mcc_to_members_only:                       false,
          
                show_last_name_to_public:                       true,
                show_last_name_to_members_only:                 false,

                show_legal_name_to_public:                      true,
                show_legal_name_to_members_only:                false,
          
                show_phone_number_to_public:                    true,
                show_phone_number_to_members_only:              false,
          
                show_email_to_public:                           true,
                show_email_to_members_only:                     false,
          
                show_address_to_public:                         true,
                show_address_to_members_only:                   false,
          
                show_date_of_birth_to_public:                   true,
                show_date_of_birth_to_members_only:             false,

                show_relationship_to_business_to_public:        true,
                show_relationship_to_business_to_members_only:  false,

                show_percent_ownership_to_public:               true,
                show_percent_ownership_to_members_only:         false,

                show_last_4_of_ssn_to_public:                   false,
                show_last_4_of_ssn_to_members_only:             false,
            }
        else
            {
                show_tax_id_to_public:                          false,
                show_tax_id_to_members_only:                    false,
          
                show_product_description_to_public:             true,
                show_product_description_to_members_only:       false,
          
                show_mcc_to_public:                             true,
                show_mcc_to_members_only:                       false,
          
                show_last_name_to_public:                       true,
                show_last_name_to_members_only:                 false,
                
                show_legal_name_to_public:                      true,
                show_legal_name_to_members_only:                false,
          
                show_phone_number_to_public:                    true,
                show_phone_number_to_members_only:              false,
          
                show_email_to_public:                           true,
                show_email_to_members_only:                     false,
          
                show_address_to_public:                         true,
                show_address_to_members_only:                   false,
          
                show_date_of_birth_to_public:                   true,
                show_date_of_birth_to_members_only:             false,

                show_relationship_to_business_to_public:        true,
                show_relationship_to_business_to_members_only:  false,

                show_percent_ownership_to_public:               true,
                show_percent_ownership_to_members_only:         false,

                show_last_4_of_ssn_to_public:                   false,
                show_last_4_of_ssn_to_members_only:             false,
            }
        end
    end
end
