# == Schema Information
#
# Table name: progresses
#
#  id            :integer          not null, primary key
#  stage         :integer          default(1), not null
#  status        :integer          default(1), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  settlement_id :integer
#
# Indexes
#
#  index_progresses_on_settlement_id  (settlement_id)
#
# Foreign Keys
#
#  settlement_id  (settlement_id => settlements.id)
#
require "test_helper"

class ProgressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end