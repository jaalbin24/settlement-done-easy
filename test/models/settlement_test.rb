# == Schema Information
#
# Table name: settlements
#
#  id                 :bigint           not null, primary key
#  claim_number       :string
#  completed          :boolean          default(FALSE), not null
#  defendant_name     :string
#  dollar_amount      :float
#  incident_date      :date
#  incident_location  :string
#  plaintiff_name     :string
#  policy_number      :string
#  stage              :integer          default(1), not null
#  status             :integer          default(1), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  attorney_id        :bigint
#  insurance_agent_id :bigint
#  log_book_id        :bigint
#
# Indexes
#
#  index_settlements_on_attorney_id         (attorney_id)
#  index_settlements_on_insurance_agent_id  (insurance_agent_id)
#  index_settlements_on_log_book_id         (log_book_id)
#
# Foreign Keys
#
#  fk_rails_...  (attorney_id => users.id)
#  fk_rails_...  (insurance_agent_id => users.id)
#  fk_rails_...  (log_book_id => log_books.id)
#

#
# Indexes
#
#    index_settlements_on_insurance_agent_id    (insurance_agent_id)
#    index_settlements_on_attorney_id                     (attorney_id)
#
# Foreign Keys
#
#    insurance_agent_id    (insurance_agent_id => users.id)
#    attorney_id                     (attorney_id => users.id)
#
require "test_helper"

class SettlementTest < ActiveSupport::TestCase

    test "fixtures are valid" do
        assert !settlements.empty?, "There are no Settlement fixtures to test!"
        settlements.each do |s|
            assert s.valid?, s.errors.full_messages.inspect
        end
    end

    test "settlement amount must be present" do
        settlements.each do |s|
            assert s.valid?, s.errors.full_messages.inspect
            s.dollar_amount = 0
            assert_not s.valid?, "Settlement considered valid when dollar_amount = 0"
        end
    end
end
