# == Schema Information
#
# Table name: payments
#
#  id                          :bigint           not null, primary key
#  amount                      :float            not null
#  status                      :string           default("Pending"), not null
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

    validates :status, inclusion: {in: ["Pending", "Error", "Canceled", "Complete"]}

    def execute_inbound_transfer
        inbound_transfer = Stripe::Treasury::InboundTransfer.create(
            {
                financial_account: settlement.insurance_agent.organization.stripe_financial_account_id,
                amount: (amount * 100).round,
                currency: 'usd',
                origin_payment_method: source.stripe_payment_method_id,
                description: "Settlement of $#{amount} for #{settlement.plaintiff_name}",
            },
            {stripe_account: settlement.insurance_agent.organization.stripe_account_id}
        )
        self.stripe_inbound_transfer_id = inbound_transfer.id
        self.save
    end

    def execute_outbound_payment
        outbound_payment = Stripe::Treasury::OutboundPayment.create(
            {
                financial_account: settlement.insurance_agent.organization.stripe_financial_account_id,
                amount: (amount * 100).round,
                currency: 'usd',
                statement_descriptor: "Settlement of $#{amount} for #{settlement.plaintiff_name}",
                destination_payment_method_data: {
                    type: 'financial_account',
                    financial_account: settlement.attorney.organization.stripe_financial_account_id,
                },
            },
            {stripe_account: settlement.insurance_agent.organization.stripe_account_id},
        )
        self.stripe_outbound_payment_id = outbound_payment.id
        self.save
    end

    def execute_outbound_transfer
        outbound_transfer = Stripe::Treasury::OutboundTransfer.create(
            {
                financial_account: settlement.attorney.organization.stripe_financial_account_id,
                amount: (amount * 100).round,
                currency: 'usd',
                statement_descriptor: "SDE Payout",
                destination_payment_method: destination.stripe_payment_method_id,
                destination_payment_method_options: {us_bank_account: {network: 'ach'}},
            },
            {stripe_account: settlement.attorney.organization.stripe_account_id},
        )
        self.stripe_outbound_transfer_id = outbound_transfer.id
        self.save
    end

    def complete
        self.status = "Complete"
        self.save
    end

    def completed?
        return status == "Complete"
    end
end
