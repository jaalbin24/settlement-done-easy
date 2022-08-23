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
class PaymentLogEntry < ApplicationRecord
    belongs_to(
        :payment,
        class_name: "Payment",
        foreign_key: "payment_id",
        inverse_of: :log_entries
    )

    belongs_to(
        :user,
        class_name: "User",
        foreign_key: "user_id",
        optional: true
    )
end
