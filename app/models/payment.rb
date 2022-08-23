# == Schema Information
#
# Table name: payments
#
#  id                          :bigint           not null, primary key
#  amount                      :float            not null
#  completed_at                :datetime
#  status                      :string           default("Not sent"), not null
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
#  index_payments_on_destination_id               (destination_id)
#  index_payments_on_settlement_id                (settlement_id)
#  index_payments_on_source_id                    (source_id)
#  index_payments_on_stripe_inbound_transfer_id   (stripe_inbound_transfer_id) UNIQUE
#  index_payments_on_stripe_outbound_payment_id   (stripe_outbound_payment_id) UNIQUE
#  index_payments_on_stripe_outbound_transfer_id  (stripe_outbound_transfer_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (destination_id => bank_accounts.id)
#  fk_rails_...  (settlement_id => settlements.id)
#  fk_rails_...  (source_id => bank_accounts.id)
#
class Payment < ApplicationRecord

    scope :with_inbound_transfer_id,    ->  (stripe_id) {where(stripe_inbound_transfer_id: stripe_id)}
    scope :with_outbound_payment_id,    ->  (stripe_id) {where(stripe_outbound_payment_id: stripe_id)}
    scope :with_outbound_transfer_id,   ->  (stripe_id) {where(stripe_outbound_transfer_id: stripe_id)}

    scope :processing,                  ->              {where(status: "Processing")}
    scope :active,                      ->              {where.not(status: "Failed").and(where.not(status: "Canceled").and(where.not(status: "Returned")))}
    scope :completed,                   ->              {where(status: "Complete")}
    belongs_to(
        :settlement,
        class_name: "Settlement",
        foreign_key: "settlement_id",
        inverse_of: :payments
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

    has_many(
        :log_entries,
        class_name: "PaymentLogEntry",
        foreign_key: "payment_id",
        inverse_of: :payment,
        dependent: :destroy
    )

    validates :status, inclusion: {in: ["Not sent", "Processing", "Failed", "Canceled", "Complete", "Returned"]}
    validates :source, :destination, :amount, presence: true
    
    validate :amount_is_above_allowed_threshold
    def amount_is_above_allowed_threshold
        errors.add(:amount, "must be greater than $#{Rails.configuration.PAYMENT_MINIMUM_IN_DOLLARS}") unless amount > Rails.configuration.PAYMENT_MINIMUM_IN_DOLLARS
    end
    
    validate :amount_is_below_allowed_threshold
    def amount_is_below_allowed_threshold
        errors.add(:amount, "must be less than $#{Rails.configuration.PAYMENT_MAXIMUM_IN_DOLLARS}") unless amount < Rails.configuration.PAYMENT_MAXIMUM_IN_DOLLARS
    end
    validate :source_belongs_to_insurance_company
    def source_belongs_to_insurance_company
        errors.add(:source, "must belong to an Insurance Company.") unless source.user.isInsuranceCompany?
    end

    validate :destination_belongs_to_law_firm
    def destination_belongs_to_law_firm
        errors.add(:destination, "must belong to a Law Firm.") unless destination.user.isLawFirm?
    end

    before_save do
        generate_any_logs
    end

    def generate_any_logs
        if status_changed?
            if processing?
                log_entries.build(
                    user: settlement.insurance_agent,
                    message: "Payment of $#{amount} initiated."
                )
            elsif failed?
                log_entries.build(
                    message: "Payment failed."
                )
            elsif canceled?
                log_entries.build(
                    message: "Payment canceled."
                )
            elsif completed?
                log_entries.build(
                    message: "Payment completed."
                )
            elsif returned?
                log_entries.build(
                    message: "Payment returned."
                )
            end
        end
        if stripe_outbound_payment_id_changed?
            log_entries.build(
                message: "SDE recieved funds from #{source.user.business_name}."
            )
            log_entries.build(
                message: "SDE sent funds to #{destination.user.business_name}."
            )
        end
    end

    def execute_inbound_transfer
        inbound_transfer = Stripe::Treasury::InboundTransfer.create(
            {
                financial_account: settlement.insurance_agent.organization.stripe_financial_account_id,
                amount: amount_in_cents,
                currency: 'usd',
                origin_payment_method: source.stripe_payment_method_id,
                description: "Settlement of $#{amount} for #{settlement.plaintiff_name}",
            },
            {stripe_account: settlement.insurance_agent.organization.stripe_account_id}
        )
        self.stripe_inbound_transfer_id = inbound_transfer.id
        self.status = "Processing"
        if !self.save
            puts "⚠️⚠️⚠️ ERROR: #{self.errors.full_messages.inspect}"
        end
    end

    def execute_outbound_payment
        if stripe_inbound_transfer_id.blank?
            raise StandardError.new "Inbound transfer must be executed before outbound payment."
        end
        if !stripe_outbound_payment_id.blank?
            raise StandardError.new "Outbound payment already executed."
        end

        outbound_payment = Stripe::Treasury::OutboundPayment.create(
            {
                financial_account: settlement.insurance_agent.organization.stripe_financial_account_id,
                amount: amount_in_cents,
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
        if !self.save
            puts "⚠️⚠️⚠️ ERROR: #{self.errors.full_messages.inspect}"
        end
    end

    def execute_outbound_transfer
        if stripe_inbound_transfer_id.blank?
            raise StandardError.new "Inbound transfer must be executed before outbound payment."
        end
        if stripe_outbound_payment_id.blank?
            raise StandardError.new "Outbound payment must be executed before outbound transfer."
        end
        if !stripe_outbound_transfer_id.blank?
            raise StandardError.new "Outbound transfer already executed."
        end
        outbound_transfer = Stripe::Treasury::OutboundTransfer.create(
            {
                financial_account: settlement.attorney.organization.stripe_financial_account_id,
                amount: amount_in_cents,
                currency: 'usd',
                statement_descriptor: "SDE Payout",
                destination_payment_method: destination.stripe_payment_method_id,
                destination_payment_method_options: {us_bank_account: {network: 'ach'}},
            },
            {stripe_account: settlement.attorney.organization.stripe_account_id},
        )
        self.stripe_outbound_transfer_id = outbound_transfer.id
        if !self.save
            puts "⚠️⚠️⚠️ ERROR: #{self.errors.full_messages.inspect}"
        end
    end

    def amount_in_cents
        return (amount * 100).round
    end

    def complete
        self.status = "Complete"
        self.completed_at = DateTime.now
        if !self.save
            puts "⚠️⚠️⚠️ ERROR: #{self.errors.full_messages.inspect}"
        end
    end

    def processing?
        return status == "Processing"
    end

    def canceled?
        return status == "Canceled"
    end

    def failed?
        return status == "Failed"
    end

    def returned?
        return status == "Returned"
    end

    def completed?
        return status == "Complete"
    end
end
