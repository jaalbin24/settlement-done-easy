# == Schema Information
#
# Table name: payments
#
#  id                          :bigint           not null, primary key
#  amount                      :float            not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  destination_id              :bigint
#  settlement_id               :bigint
#  source_id                   :bigint
#  stripe_inbound_transfer_id  :string
#  stripe_outbound_payment_id  :string
#  stripe_outbound_transfer_id :string
#
# Indexes
#
#  index_payments_on_destination_id  (destination_id)
#  index_payments_on_settlement_id   (settlement_id)
#  index_payments_on_source_id       (source_id)
#
# Foreign Keys
#
#  fk_rails_...  (destination_id => bank_accounts.id)
#  fk_rails_...  (settlement_id => settlements.id)
#  fk_rails_...  (source_id => bank_accounts.id)
#
class Payment < ApplicationRecord
    belongs_to(
        :settlement,
        class_name: "Settlement",
        foreign_key: "settlement_id",
        inverse_of: :payment
    )

    belongs_to(
        :source,
        class_name: "BankAccount",
        foreign_key: "source_id",
        inverse_of: :payments_out
    )

    belongs_to(
        :destination,
        class_name: "BankAccount",
        foreign_key: "destination_id",
        inverse_of: :payments_in
    )
end
