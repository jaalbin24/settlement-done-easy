# == Schema Information
#
# Table name: settlements
#
#  id                 :bigint           not null, primary key
#  amount             :float
#  canceled           :boolean          default(FALSE), not null
#  claim_number       :string
#  claimant_name      :string
#  completed          :boolean          default(FALSE), not null
#  incident_date      :date
#  incident_location  :string
#  locked             :boolean          default(FALSE), not null
#  policy_holder_name :string
#  policy_number      :string
#  public_number      :integer
#  ready_for_payment  :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  adjuster_id        :bigint
#  attorney_id        :bigint
#  log_book_id        :bigint
#  public_id          :string
#  started_by_id      :bigint
#
# Indexes
#
#  index_settlements_on_adjuster_id    (adjuster_id)
#  index_settlements_on_attorney_id    (attorney_id)
#  index_settlements_on_log_book_id    (log_book_id)
#  index_settlements_on_started_by_id  (started_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (adjuster_id => users.id)
#  fk_rails_...  (attorney_id => users.id)
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (started_by_id => users.id)
#

#
# Indexes
#
#    index_settlements_on_adjuster_id    (adjuster_id)
#    index_settlements_on_attorney_id                     (attorney_id)
#
# Foreign Keys
#
#    adjuster_id    (adjuster_id => users.id)
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
            s.amount = 0
            assert_not s.valid?, "Settlement considered valid when amount = 0"
        end
    end
end
