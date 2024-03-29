# == Schema Information
#
# Table name: payments
#
#  id                          :bigint           not null, primary key
#  amount                      :float            not null
#  completed_at                :datetime
#  started_at                  :datetime
#  status                      :string           not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  log_book_id                 :bigint
#  public_id                   :string
#  settlement_id               :bigint
#  stripe_inbound_transfer_id  :string
#  stripe_outbound_payment_id  :string
#  stripe_outbound_transfer_id :string
#
# Indexes
#
#  index_payments_on_log_book_id                  (log_book_id)
#  index_payments_on_settlement_id                (settlement_id)
#  index_payments_on_stripe_inbound_transfer_id   (stripe_inbound_transfer_id) UNIQUE
#  index_payments_on_stripe_outbound_payment_id   (stripe_outbound_payment_id) UNIQUE
#  index_payments_on_stripe_outbound_transfer_id  (stripe_outbound_transfer_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (settlement_id => settlements.id)
#
class Payment < ApplicationRecord
    scope :with_inbound_transfer_id,    ->  (stripe_id) {where(stripe_inbound_transfer_id: stripe_id)}
    scope :with_outbound_payment_id,    ->  (stripe_id) {where(stripe_outbound_payment_id: stripe_id)}
    scope :with_outbound_transfer_id,   ->  (stripe_id) {where(stripe_outbound_transfer_id: stripe_id)}

    scope :processing,                  ->              {where(status: "Processing")}
    scope :not_processing,              ->              {where.not(status: "Processing")}
    scope :active,                      ->              {where.not(status: "Failed").and(where.not(status: "Canceled").and(where.not(status: "Returned")))}
    scope :completed,                   ->              {where(status: "Complete")}
    scope :not_completed,               ->              {where.not(status: "Complete")}
    scope :not_sent,                    ->              {where(status: "Not sent")}
    scope :sent,                        ->              {where.not(status: "Not sent")}

    belongs_to(
        :settlement,
        class_name: "Settlement",
        foreign_key: "settlement_id",
        inverse_of: :payments,
        autosave: true
    )

    belongs_to(
        :log_book,
        class_name: "LogBook",
        foreign_key: "log_book_id",
        dependent: :destroy,
        optional: true
    )

    validates :status, inclusion: {in: -> (i) {Payment.statuses}}
    validates :amount, presence: true
    validates :amount, inclusion: {in: -> (i) {[i.settlement.amount]}, message: "must be equal to the settlement amount."}
    validates :settlement_id, inclusion: {in: -> (i) {[i.settlement_id_was]}, message: "cannot be changed after creation."}, on: :update
    validates :stripe_inbound_transfer_id, inclusion: {in: -> (i) {[i.stripe_inbound_transfer_id_was]}, message: "cannot be changed once set."}, unless: -> (i) {i.stripe_inbound_transfer_id_was.blank?}, on: :update
    validates :stripe_outbound_payment_id, inclusion: {in: -> (i) {[i.stripe_outbound_payment_id_was]}, message: "cannot be changed once set."}, unless: -> (i) {i.stripe_outbound_payment_id_was.blank?}, on: :update
    validates :stripe_outbound_transfer_id, inclusion: {in: -> (i) {[i.stripe_outbound_transfer_id_was]}, message: "cannot be changed once set."}, unless: -> (i) {i.stripe_outbound_transfer_id_was.blank?}, on: :update

    validates :stripe_inbound_transfer_id, presence: {if: :sent?}
    validates :stripe_inbound_transfer_id, absence: {unless: :sent?}
    validates :stripe_outbound_payment_id, absence: {unless: :sent?}
    validates :stripe_outbound_transfer_id, absence: {unless: :sent?}

    def self.statuses
        ["Not sent", "Processing", "Failed", "Canceled", "Complete", "Returned"]
    end
    
    validate :amount_is_above_allowed_threshold
    def amount_is_above_allowed_threshold
        errors.add(:amount, "must be greater than $#{Rails.configuration.PAYMENT_MINIMUM_IN_DOLLARS}") unless amount > Rails.configuration.PAYMENT_MINIMUM_IN_DOLLARS
    end
    
    validate :amount_is_below_allowed_threshold
    def amount_is_below_allowed_threshold
        errors.add(:amount, "must be less than $#{Rails.configuration.PAYMENT_MAXIMUM_IN_DOLLARS}") unless amount < Rails.configuration.PAYMENT_MAXIMUM_IN_DOLLARS
    end
    # validate :source_belongs_to_insurance_company
    # def source_belongs_to_insurance_company
    #     unless source.nil?
    #         errors.add(:source, "must belong to an Insurance Company.") unless source.user.isInsuranceCompany?
    #     end
    # end

    # validate :destination_belongs_to_law_firm
    # def destination_belongs_to_law_firm
    #     unless destination.nil?
    #         errors.add(:destination, "must belong to a Law Firm.") unless destination.user.isLawFirm?
    #     end
    # end

    validate :amount_matches_settlement_amount
    def amount_matches_settlement_amount
        errors.add(:amount, "cannot be different from settlement amount.") unless amount == settlement.amount
    end

    validate :changes_are_allowed_when_settlement_is_locked
    def changes_are_allowed_when_settlement_is_locked
        if settlement.locked?
            changed_attributes.keys.each do |a|
                unless Payment.attributes_that_can_be_changed_when_settlement_is_locked.include?(a.to_sym)
                    # raise SafetyError::PaymentSafetyError.new "You cannot change the source bank account while the settlement is locked."       if source_id_changed?
                    # raise SafetyError::PaymentSafetyError.new "You cannot change the destination bank account while the settlement is locked."  if destination_id_changed?
                    raise SafetyError::PaymentSafetyError.new "You cannot change the payment amount while the settlement is locked."            if amount_changed?
                    puts "❗❗❗ Changed payment attributes=#{changed_attributes}"
                    raise SafetyError::PaymentSafetyError.new "This settlement is locked. You cannot change payment details."
                end
            end
        end
    end
    def self.attributes_that_can_be_changed_when_settlement_is_locked
        [:stripe_inbound_transfer_id, :stripe_outbound_payment_id, :stripe_outbound_transfer_id, :status, :completed_at]
    end

    before_validation do
        puts "❤️❤️❤️ Payment before_validation block"
        if status.blank?
            self.status = "Not sent"
        end
        if amount != settlement.amount
            self.amount = settlement.amount
        end
    end

    before_destroy do
        puts "❤️❤️❤️ Payment before_destroy block"
    end

    before_create do
        puts "❤️❤️❤️ Payment before_create block"
        create_log_book_model_if_self_lacks_one
    end

    before_save do
        puts "❤️❤️❤️ Payment before_save block"
        unless log_book.nil?
            log_book.save
        end
    end
    
    after_commit do
        puts "❤️❤️❤️ Payment after_commit block"
        if saved_changes? && !new_record? && !settlement.frozen?
            settlement.save
        end
    end


    def create_log_book_model_if_self_lacks_one
        self.log_book = LogBook.create! if log_book.nil?
    end

    def execute_inbound_transfer
        SafetyError::Payments.raise_error_unless_safe_to_execute_inbound_transfer_on self
        inbound_transfer = Stripe::Treasury::InboundTransfer.create(
            {
                financial_account: settlement.adjuster.organization.stripe_financial_account_id,
                amount: amount_in_cents,
                currency: 'usd',
                origin_payment_method: source.stripe_payment_method_id,
                description: "Settlement of $#{amount} for #{settlement.claimant_name}",
            },
            {stripe_account: settlement.adjuster.organization.stripe_account_id}
        )
        self.stripe_inbound_transfer_id = inbound_transfer.id
        self.status = "Processing"
        self.started_at = DateTime.now
        unless self.save
            # TODO: An inbound transfer failed! Send yourself an email with the following info:
            # - inbound_transfer_id
            # - organization & member user
            # - error message.
            puts "⚠️⚠️⚠️ ERROR: #{self.errors.full_messages.inspect}"
        end
    end

    def execute_outbound_payment
        SafetyError::Payments.raise_error_unless_safe_to_execute_outbound_payment_on self
        outbound_payment = Stripe::Treasury::OutboundPayment.create(
            {
                financial_account: settlement.adjuster.organization.stripe_financial_account_id,
                amount: amount_in_cents,
                currency: 'usd',
                statement_descriptor: "Settlement of $#{amount} for #{settlement.claimant_name}",
                destination_payment_method_data: {
                    type: 'financial_account',
                    financial_account: settlement.attorney.organization.stripe_financial_account_id,
                },
            },
            {stripe_account: settlement.adjuster.organization.stripe_account_id},
        )
        self.stripe_outbound_payment_id = outbound_payment.id
        unless self.save
            # TODO: An outbound payment failed! Send yourself an email with the following info:
            # - outbound_payment_id
            # - organization & member user
            # - error message.
            puts "⚠️⚠️⚠️ ERROR: #{self.errors.full_messages.inspect}"
        end
    end

    def execute_outbound_transfer
        SafetyError::Payments.raise_error_unless_safe_to_execute_outbound_transfer_on self
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
        unless self.save
            # TODO: An outbound transfer failed! Send yourself an email with the following info:
            # - outbound_transfer_id
            # - organization & member user
            # - error message.
            puts "⚠️⚠️⚠️ ERROR: #{self.errors.full_messages.inspect}"
        end
    end

    def amount_in_cents
        (amount * 100).round
    end

    def sync_with_stripe
        if completed?
            return
        end
        if !stripe_outbound_transfer_id.nil?
            outbound_transfer = Stripe::Treasury::OutboundTransfer.retrieve(stripe_outbound_transfer_id, {stripe_account: settlement.attorney.organization.stripe_account_id})
            case outbound_transfer.status
            when 'posted'
                complete_payment
            when 'canceled'
                # THIS SHOULD NOT HAPPEN!
                # Send yourself an email!
            when 'failed'
                fail_payment
            when 'returned'
                return_payment
            when 'processing'

            else
                raise StandardError.new "Unhandled payment status: #{outbound_transfer.status}"
            end
        elsif !stripe_outbound_payment_id.nil?
            outbound_payment = Stripe::Treasury::OutboundPayment.retrieve(stripe_outbound_payment_id, {stripe_account: settlement.adjuster.organization.stripe_account_id})
            case outbound_payment.status
            when 'posted'
                execute_outbound_transfer
            when 'canceled'
                # THIS SHOULD NOT HAPPEN!
                # Send yourself an email!
            when 'failed'
                fail_payment
            when 'returned'
                return_payment
            when 'processing'

            else
                raise StandardError.new "Unhandled payment status: #{outbound_payment.status}"
            end
        elsif !stripe_inbound_transfer_id.nil?
            inbound_transfer = Stripe::Treasury::InboundTransfer.retrieve(stripe_inbound_transfer_id, {stripe_account: settlement.adjuster.organization.stripe_account_id})
            case inbound_transfer.status
            when 'succeeded'
                execute_outbound_payment
            when 'canceled'
                cancel_payment
            when 'failed'
                fail_payment
            when 'processing'

            else
                raise StandardError.new "Unhandled payment status: #{outbound_payment.status}"
            end
        end
    end

    def complete_payment
        SafetyError::Payments.raise_error_unless_safe_to_complete self
        self.status = "Complete"
        self.completed_at = DateTime.now
        unless self.save
            puts "⚠️⚠️⚠️ ERROR: #{self.errors.full_messages.inspect}"
        end
    end

    def cancel_payment
        if canceled?
            raise StandardError.new "Payment is already canceled."
        else
            self.status = "Canceled"
            self.completed_at = DateTime.now
            if !self.save
                puts "⚠️⚠️⚠️ ERROR: #{self.errors.full_messages.inspect}"
            end
        end
    end

    def fail_payment
        if failed?
            raise StandardError.new "Payment is already failed."
        else
            self.status = "Failed"
            unless self.save
                puts "⚠️⚠️⚠️ ERROR: #{self.errors.full_messages.inspect}"
            end
        end
    end

    def return_payment
        if returned?
            raise StandardError.new "Payment is already returned."
        else
            self.status = "Returned"
            unless self.save
                puts "⚠️⚠️⚠️ ERROR: #{self.errors.full_messages.inspect}"
            end
        end
    end

    def sent?
        status != "Not sent"
    end

    def processing?
        status == "Processing"
    end

    def canceled?
        status == "Canceled"
    end

    def failed?
        status == "Failed"
    end

    def returned?
        status == "Returned"
    end

    def completed?
        status == "Complete"
    end
end
