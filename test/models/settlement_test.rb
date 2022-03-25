# == Schema Information
#
# Table name: settlements
#

#
# Indexes
#
#  index_settlements_on_insurance_agent_id  (insurance_agent_id)
#  index_settlements_on_lawyer_id           (lawyer_id)
#
# Foreign Keys
#
#  insurance_agent_id  (insurance_agent_id => users.id)
#  lawyer_id           (lawyer_id => users.id)
#
require "test_helper"

class SettlementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
