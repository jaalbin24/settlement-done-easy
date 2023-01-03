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
require 'rails_helper'

RSpec.describe UserProfileSettings, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
