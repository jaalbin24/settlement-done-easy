# == Schema Information
#
# Table name: payment_request_log_entries
#
#  id                 :bigint           not null, primary key
#  message            :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  payment_request_id :bigint
#  user_id            :bigint
#
# Indexes
#
#  index_payment_request_log_entries_on_payment_request_id  (payment_request_id)
#  index_payment_request_log_entries_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (payment_request_id => payment_requests.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class PaymentRequestLogEntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
