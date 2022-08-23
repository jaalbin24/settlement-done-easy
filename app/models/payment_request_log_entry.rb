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
class PaymentRequestLogEntry < ApplicationRecord
    belongs_to(
        :payment_request,
        class_name: "PaymentRequest",
        foreign_key: "payment_request_id",
        inverse_of: :log_entries
    )

    belongs_to(
        :user,
        class_name: "User",
        foreign_key: "user_id",
        optional: true
    )
end
