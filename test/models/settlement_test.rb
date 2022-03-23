# == Schema Information
#
# Table name: settlements
#
#  id                 :integer          not null, primary key
#  claim_number       :string
#  date_of_incident   :date
#  defendent_name     :string
#  plaintiff_name     :string
#  policy_number      :string
#  settlement_amount  :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  insurance_agent_id :integer
#  lawyer_id          :integer
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
