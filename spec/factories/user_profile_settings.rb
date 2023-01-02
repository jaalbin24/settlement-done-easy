# == Schema Information
#
# Table name: user_profile_settings
#
#  id                                         :bigint           not null, primary key
#  hide_address_from_members                  :boolean
#  hide_address_from_public                   :boolean
#  hide_date_of_birth_from_members            :boolean
#  hide_date_of_birth_from_public             :boolean
#  hide_email_from_members                    :boolean
#  hide_email_from_public                     :boolean
#  hide_last_4_of_ssn_from_members            :boolean
#  hide_last_4_of_ssn_from_public             :boolean
#  hide_last_name_from_members                :boolean
#  hide_last_name_from_public                 :boolean
#  hide_mcc_from_members                      :boolean
#  hide_mcc_from_public                       :boolean
#  hide_percent_ownership_from_members        :boolean
#  hide_percent_ownership_from_public         :boolean
#  hide_phone_number_from_members             :boolean
#  hide_phone_number_from_public              :boolean
#  hide_product_description_from_members      :boolean
#  hide_product_description_from_public       :boolean
#  hide_relationship_to_business_from_members :boolean
#  hide_relationship_to_business_from_public  :boolean
#  hide_tax_id_from_members                   :boolean
#  hide_tax_id_from_public                    :boolean
#  created_at                                 :datetime         not null
#  updated_at                                 :datetime         not null
#  public_id                                  :string
#  user_settings_id                           :bigint
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
  factory :user_profile_settings do
    
  end
end
