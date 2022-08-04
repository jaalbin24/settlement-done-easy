# == Schema Information
#
# Table name: stripe_payment_intents
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  settlement_id :bigint           not null
#  stripe_id     :string           not null
#
# Indexes
#
#  index_stripe_payment_intents_on_settlement_id  (settlement_id)
#
# Foreign Keys
#
#  fk_rails_...  (settlement_id => settlements.id)
#
require "test_helper"

class StripePaymentIntentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
