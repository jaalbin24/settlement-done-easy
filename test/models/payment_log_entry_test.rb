# == Schema Information
#
# Table name: payment_log_entries
#
#  id         :bigint           not null, primary key
#  message    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  payment_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_payment_log_entries_on_payment_id  (payment_id)
#  index_payment_log_entries_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (payment_id => payments.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class PaymentLogEntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
