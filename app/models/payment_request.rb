# == Schema Information
#
# Table name: payment_requests
#
#  id            :bigint           not null, primary key
#  status        :string           default("Requested"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  requester_id  :bigint
#  settlement_id :bigint
#
# Indexes
#
#  index_payment_requests_on_requester_id   (requester_id)
#  index_payment_requests_on_settlement_id  (settlement_id)
#
# Foreign Keys
#
#  fk_rails_...  (requester_id => users.id)
#  fk_rails_...  (settlement_id => settlements.id)
#
class PaymentRequest < ApplicationRecord

    belongs_to(
        :requester,
        class_name: "User",
        foreign_key: "requester_id"
    )

    belongs_to(
        :settlement,
        class_name: "Settlement",
        foreign_key: "settlement_id"
    )

    validate :requester_is_affiliated_with_settlement
    def requester_is_affiliated_with_settlement
        errors.add(:requester, "is not affiliated with that settlement.") unless settlement.insurance_agent == requester || settlement.attorney == requester
    end
end
