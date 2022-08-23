# == Schema Information
#
# Table name: settlements
#
#  id                  :bigint           not null, primary key
#  claim_number        :string
#  completed           :boolean          default(FALSE), not null
#  defendant_name      :string
#  dollar_amount       :float
#  incident_date       :date
#  incident_location   :string
#  payment_has_error   :boolean          default(FALSE), not null
#  payment_made        :boolean          default(FALSE), not null
#  payment_received    :boolean          default(FALSE), not null
#  plaintiff_name      :string
#  policy_number       :string
#  signature_requested :boolean          default(FALSE), not null
#  stage               :integer          default(1), not null
#  status              :integer          default(1), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  attorney_id         :bigint
#  insurance_agent_id  :bigint
#
# Indexes
#
#  index_settlements_on_attorney_id         (attorney_id)
#  index_settlements_on_insurance_agent_id  (insurance_agent_id)
#
# Foreign Keys
#
#  fk_rails_...  (attorney_id => users.id)
#  fk_rails_...  (insurance_agent_id => users.id)
#
class Settlement < ApplicationRecord
    include DocumentGenerator

    validates :dollar_amount, presence: true
    validates :completed, inclusion: {in: [false], unless: :payment_received, message: "cannot be true when payment received is false"}
    validates :payment_received, inclusion: {in: [false], unless: :payment_made, message: "cannot be true when payment made is false"}
    validates :payment_has_error, inclusion: {in: [false], unless: :payment_made, message: "cannot be true when payment made is false"}
    validate :one_or_less_active_payment
    def one_or_less_active_payment
        errors.add(:payments, "can only have one active payment at a time.") unless payments.active.size <= 1
    end

    validate :amount_is_above_allowed_threshold
    def amount_is_above_allowed_threshold
        errors.add(:dollar_amount, "must be greater than $#{Rails.configuration.PAYMENT_MINIMUM_IN_DOLLARS}") unless dollar_amount > Rails.configuration.PAYMENT_MINIMUM_IN_DOLLARS
    end
    
    validate :amount_is_below_allowed_threshold
    def amount_is_below_allowed_threshold
        errors.add(:dollar_amount, "must be less than $#{Rails.configuration.PAYMENT_MAXIMUM_IN_DOLLARS}") unless dollar_amount < Rails.configuration.PAYMENT_MAXIMUM_IN_DOLLARS
    end

    belongs_to(
        :attorney,
        class_name: "User",
        foreign_key: "attorney_id",
    )

    belongs_to(
        :insurance_agent,
        class_name: "User",
        foreign_key: "insurance_agent_id",
    )

    has_many(
        :documents,
        class_name: "Document",
        foreign_key: "settlement_id",
        inverse_of: :settlement,
        dependent: :destroy
    )

    has_many(
        :payments,
        class_name: "Payment",
        foreign_key: "settlement_id",
        inverse_of: :settlement,
        dependent: :destroy
    )

    has_many(
        :payment_requests,
        class_name: "PaymentRequest",
        foreign_key: "settlement_id",
        inverse_of: :settlement,
        dependent: :destroy
    )

    has_many(
        :log_entries,
        class_name: "SettlementLogEntry",
        foreign_key: "settlement_id",
        inverse_of: :settlement,
        dependent: :destroy
    )

    before_save do
        generate_any_logs
    end

    after_commit do
        if !self.frozen? # The .frozen? check keeps an error from being thrown when deleting settlement models
            self.update_progress
            if self.changed?
                self.save
            else
                puts "====> NOT CHANGED"    
            end
        end
    end

    after_create do
        payments.create!(
            source: insurance_agent.organization.default_bank_account,
            destination: attorney.organization.default_bank_account,
            amount: dollar_amount
        )
    end

    def generate_any_logs
        puts "METHOD IS HITTING"
        if new_record?
            puts "FIRST ONE"
            log_entries.build(
                message: "New settlement started."
            )
        end
        if completed_changed?
            puts "SECOND ONE"
            log_entries.build(
                message: "Settlement completed."
            )
        end
    end

    def has_documents?
        if documents == nil || documents.empty? || !documents.exists?
            puts "====> FALSE documents.size=#{documents.size}"
            return false
        else
            puts "====> TRUE documents.size=#{documents.size}"
            return true
        end
    end

    def generated_document_file_name
        "#{self.claim_number}_release.pdf"
    end

    def status_message
        return SettlementProgress.status_message(self)
    end

    def has_approved_and_signed_document?
        documents.each do |d|
            if d.approved? && d.signed?
                return true
            end
        end
        return false
    end

    def has_approved_document?
        documents.each do |d|
            if d.approved?
                return true
            end
        end
        return false
    end

    def has_waiting_document?
        documents.each do |d|
            if !d.approved? && !d.rejected?
                return true
            end
        end
        return false
    end

    def has_document_with_signature_request?
        documents.each do |d|
            if d.ds_envelope_id != nil
                return true
            end
        end
        return false
    end

    def has_unapproved_signed_document?
        documents.each do |d|
            if !d.approved? && d.signed?
                return true
            end
        end
        return false
    end

    def document_with_signature_request
        documents.each do |d|
            if d.ds_envelope_id != nil
                return d
            end
        end
    end

    def document_that_needs_signature
        documents.each do |d|
            if d.approved? && !d.signed? && d.ds_envelope_id == nil
                return d
            end
        end
    end

    def first_waiting_document
        documents.each do |d|
            if !d.approved? && !d.rejected?
                return d
            end
        end
    end
    
    def update_progress
        puts "====> SETTLEMENT PROGRESS UPDATED"
        puts "====> WAS stage=#{stage}, status=#{status}"
        if !has_documents?
            self.stage = 1
            self.status = 1
        elsif !has_approved_document?
            self.stage = 1
            if has_waiting_document?
                self.status = 2
            else
                self.status = 3
            end
        elsif !has_approved_and_signed_document?
            self.stage = 2
            self.status = 1
            if has_document_with_signature_request?
                self.status = 2
            elsif has_unapproved_signed_document?
                self.status = 3
            end
        elsif !payment_made?
            self.stage = 3
            self.status = 1
        elsif !payment_received?
            self.stage = 3
            self.status = 2
        elsif !completed?
            self.stage = 3
            self.status = 4
        elsif completed?
            self.stage = 4
            self.status = 1
        end
        puts "====> NOW stage=#{stage}, status=#{status}"
    end

    def ready_for_payment?
        if documents.empty? # If settlement has no documents
            return false
        elsif documents.rejected.exists? # If settlement has rejected documents
            return false
        elsif documents.waiting_for_review.exists? # If settlement has unapproved documents
            return false
        elsif documents.unsigned.need_signature.exists? # If settlement has unsigned documents that should be signed
            return false
        else
            return true
        end
    end

    def active_payment
        return payments.active.first
    end

    def active_payment_request
        return payment_requests.active.first
    end

    def has_unanswered_payment_request?
        return payment_requests.unanswered.exists?
    end

    def has_ongoing_payment?
        return active_payment.processing?
    end

    def has_completed_payment?
        return payments.completed.exists?
    end

    def initiate_payment
        if !ready_for_payment?
            raise StandardError.new "Settlement not ready for payment!"
        else
            active_payment.execute_inbound_transfer
        end
    end
end
