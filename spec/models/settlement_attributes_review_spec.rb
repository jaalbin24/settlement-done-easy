# == Schema Information
#
# Table name: settlement_attributes_reviews
#
#  id                          :bigint           not null, primary key
#  amount_approved             :boolean
#  claim_number_approved       :boolean
#  claimant_name_approved      :boolean
#  incident_date_approved      :boolean
#  incident_location_approved  :boolean
#  policy_holder_name_approved :boolean
#  policy_number_approved      :boolean
#  status                      :string
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  public_id                   :string
#  settlement_id               :bigint
#  user_id                     :bigint
#
# Indexes
#
#  index_settlement_attributes_reviews_on_settlement_id  (settlement_id)
#  index_settlement_attributes_reviews_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (settlement_id => settlements.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe SettlementAttributesReview, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
