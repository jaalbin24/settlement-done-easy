# == Schema Information
#
# Table name: user_profiles
#
#  id                       :bigint           not null, primary key
#  date_of_birth            :date
#  email                    :string
#  first_name               :string
#  last_4_of_ssn            :integer
#  last_name                :string
#  mcc                      :integer
#  percent_ownership        :integer
#  phone_number             :bigint
#  product_description      :string
#  relationship_to_business :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  address_id               :bigint
#  public_id                :string
#  tax_id                   :string
#  user_id                  :bigint
#
# Indexes
#
#  index_user_profiles_on_address_id  (address_id)
#  index_user_profiles_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (address_id => addresses.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :user_profile do
    
  end
end
