# == Schema Information
#
# Table name: payments
#
#  id                          :bigint           not null, primary key
#  amount                      :float            not null
#  completed_at                :datetime
#  status                      :string           not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  destination_id              :bigint
#  log_book_id                 :bigint
#  public_id                   :string
#  settlement_id               :bigint
#  source_id                   :bigint
#  stripe_inbound_transfer_id  :string
#  stripe_outbound_payment_id  :string
#  stripe_outbound_transfer_id :string
#
# Indexes
#
#  index_payments_on_destination_id               (destination_id)
#  index_payments_on_log_book_id                  (log_book_id)
#  index_payments_on_settlement_id                (settlement_id)
#  index_payments_on_source_id                    (source_id)
#  index_payments_on_stripe_inbound_transfer_id   (stripe_inbound_transfer_id) UNIQUE
#  index_payments_on_stripe_outbound_payment_id   (stripe_outbound_payment_id) UNIQUE
#  index_payments_on_stripe_outbound_transfer_id  (stripe_outbound_transfer_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (destination_id => bank_accounts.id)
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (settlement_id => settlements.id)
#  fk_rails_...  (source_id => bank_accounts.id)
#
FactoryBot.define do
    factory :payment, class: "Payment" do
        source
        destination
        settlement
        amount {}
        status {}
        stripe_inbound_transfer_id {"FakeInboundTransferId"}
        stripe_outbound_payment_id {"FakeOutboundPaymentId"}
        stripe_outbound_transfer_id {"FakeOutboundTransferId"}

        after(:build) do |p, e|
            p.amount = p.settlement.amount
        end

        trait :processing do
            stripe_inbound_transfer_id {"FakeStripeInboundTransferId"}
            status {"Processing"}
        end

        trait :completed do
            stripe_inbound_transfer_id {"FakeStripeInboundTransferId"}
            status {"Complete"}
        end

    end
end
