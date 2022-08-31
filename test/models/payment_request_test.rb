# == Schema Information
#
# Table name: payment_requests
#
#  id            :bigint           not null, primary key
#  status        :string           default("Requested"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  accepter_id   :bigint
#  log_book_id   :bigint
#  requester_id  :bigint
#  settlement_id :bigint
#
# Indexes
#
#  index_payment_requests_on_accepter_id    (accepter_id)
#  index_payment_requests_on_log_book_id    (log_book_id)
#  index_payment_requests_on_requester_id   (requester_id)
#  index_payment_requests_on_settlement_id  (settlement_id)
#
# Foreign Keys
#
#  fk_rails_...  (accepter_id => users.id)
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (requester_id => users.id)
#  fk_rails_...  (settlement_id => settlements.id)
#
require "test_helper"

class PaymentRequestTest < ActiveSupport::TestCase
    test "fixtures are valid" do
        assert !payment_requests.empty?, "There are no PaymentRequest fixtures to test!"
        payment_requests.each do |pr|
            assert pr.valid?, pr.errors.full_messages.inspect
        end
    end
end
