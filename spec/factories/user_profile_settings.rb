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
FactoryBot.define do
    factory  :user_profile_settings do
        # transient do
        #     show_public {}
        #     show_members_only {}
        # end

        # after( {false}create) do |up, e|
        #     unless e.show_public.nil?
        #         e.show_public.each do |key, value|
        #             up.write_attribute("show_#{key.to_s}_to_public".to_sym, value)
        #             up.write_attribute("show_#{key.to_s}_to_members_only".to_sym, !value)
        #             up.save
        #         end
        #     end
        #     unless e.show_members_only.nil?
        #         e.show_members_only.each do |key, value|
        #             up.write_attribute("show_#{key.to_s}_to_members_only".to_sym, value)
        #             up.write_attribute("show_#{key.to_s}_to_public".to_sym, !value)
        #             up.save
        #         end
        #     end
        # end

        show_tax_id_to_public {false}
        show_tax_id_to_members_only {false}
    
        show_product_description_to_public {false}
        show_product_description_to_members_only {false}
    
        show_mcc_to_public {false}
        show_mcc_to_members_only {false}
    
        show_last_name_to_public {false}
        show_last_name_to_members_only {false}

        show_legal_name_to_public {false}
        show_legal_name_to_members_only {false}
    
        show_phone_number_to_public {false}
        show_phone_number_to_members_only {false}
    
        show_email_to_public {false}
        show_email_to_members_only {false}
    
        show_address_to_public {false}
        show_address_to_members_only {false}
    
        show_date_of_birth_to_public {false}
        show_date_of_birth_to_members_only {false}

        show_relationship_to_business_to_public {false}
        show_relationship_to_business_to_members_only {false}

        show_percent_ownership_to_public {false}
        show_percent_ownership_to_members_only {false}

        show_last_4_of_ssn_to_public {false}
        show_last_4_of_ssn_to_members_only {false}

        factory :user_profile_settings_for_attorney do
            association :user_settings, factory: :user_settings_for_attorney
        end
        
        factory :user_profile_settings_for_adjuster do
            association :user_settings, factory: :user_settings_for_adjuster
        end
        
        association :user_settings, factory: :user_settings
    end
end
