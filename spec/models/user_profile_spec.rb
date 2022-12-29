# == Schema Information
#
# Table name: user_profiles
#
#  id                       :bigint           not null, primary key
#  date_of_birth            :date
#  first_name               :string
#  last_name                :string
#  mcc                      :integer
#  percent_ownership        :integer
#  phone_number             :integer
#  product_description      :string
#  relationship_to_business :string
#  ssn_last_4               :integer
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
require 'rails_helper'

RSpec.describe UserProfile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
