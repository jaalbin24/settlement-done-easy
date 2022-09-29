# == Schema Information
#
# Table name: settlements
#
#  id                 :bigint           not null, primary key
#  amount             :float
#  claim_number       :string
#  claimant_name      :string
#  completed          :boolean          default(FALSE), not null
#  defendant_name     :string
#  incident_date      :date
#  incident_location  :string
#  locked             :boolean          default(FALSE), not null
#  policy_number      :string
#  public_number      :integer
#  ready_for_payment  :boolean          default(FALSE), not null
#  stage              :integer          default(1), not null
#  status             :integer          default(1), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  attorney_id        :bigint
#  insurance_agent_id :bigint
#  log_book_id        :bigint
#  public_id          :string
#  started_by_id      :bigint
#
# Indexes
#
#  index_settlements_on_attorney_id         (attorney_id)
#  index_settlements_on_insurance_agent_id  (insurance_agent_id)
#  index_settlements_on_log_book_id         (log_book_id)
#  index_settlements_on_started_by_id       (started_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (attorney_id => users.id)
#  fk_rails_...  (insurance_agent_id => users.id)
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (started_by_id => users.id)
#
class Settlement < ApplicationRecord
    include DocumentGenerator

    scope :ready_for_payment,           ->      {where(ready_for_payment: true)}

    validates :amount, presence: true
    validate :one_or_less_active_payment
    def one_or_less_active_payment
        errors.add(:payments, "can only have one active payment at a time.") unless payments.active.size <= 1
    end

    validate :amount_is_above_allowed_threshold
    def amount_is_above_allowed_threshold
        errors.add(:amount, "must be greater than $#{Rails.configuration.PAYMENT_MINIMUM_IN_DOLLARS}") unless amount > Rails.configuration.PAYMENT_MINIMUM_IN_DOLLARS
    end
    
    validate :amount_is_below_allowed_threshold
    def amount_is_below_allowed_threshold
        errors.add(:amount, "must be less than $#{Rails.configuration.PAYMENT_MAXIMUM_IN_DOLLARS}") unless amount < Rails.configuration.PAYMENT_MAXIMUM_IN_DOLLARS
    end

    # Assumes reliably incrementing primary key
    validate :completed_payment_must_be_latest_payment
    def completed_payment_must_be_latest_payment
        if payments.completed.exists?
            errors.add(:payments, "is invalid. Completed payment must be the most recent payment.") unless payments.completed.first.created_at >= payments.last.created_at
        end
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
        :document_reviews,
        class_name: "DocumentReview",
        through: :documents,
        source: :reviews
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

    belongs_to(
        :log_book,
        class_name: "LogBook",
        foreign_key: "log_book_id",
        dependent: :destroy,
        optional: true
    )

    before_save do
        puts "❤️❤️❤️ Settlement before_save block"
        unless log_book.nil?
            generate_any_logs 
            log_book.save
        end
        generate_any_notifications
    end

    after_commit do
        puts "❤️❤️❤️ Settlement after_commit block"
        unless self.frozen? # The .frozen? check keeps an error from being thrown when deleting settlement models
            update_progress
            update_ready_for_payment_attribute
            if self.changed?
                self.save
            end
        end
    end

    before_create do
        puts "❤️❤️❤️ Settlement before_create block"
        create_log_book_model_if_self_lacks_one
        payments.build(
            source: insurance_agent.organization.default_bank_account,
            destination: attorney.organization.default_bank_account,
            amount: amount
        )
        self.public_number = rand(1..9999)
    end

    def generate_any_logs
        if new_record?
            log_book.entries.build(
                message: "New settlement started."
            )
        end
        if completed_changed?
            log_book.entries.build(
                message: "Settlement completed."
            )
        end
        if locked_changed?
            if locked?
                log_book.entries.build(
                    message: "Settlement locked."
                )
            else
                log_book.entries.build(
                    message: "Settlement unlocked."
                )
            end
        end
    end

    def create_log_book_model_if_self_lacks_one
        self.log_book = LogBook.create! if log_book.nil?
    end

    def generate_any_notifications
        if new_record?
            Notification.create!(
                user: insurance_agent,
                title: "New Settlement!",
                message: "A new settlement was started with #{attorney.full_name}. Click here to view it."
            )
            Notification.create!(
                user: attorney,
                title: "New Settlement!",
                message: "A new settlement was started with #{insurance_agent.full_name}. Click here to view it."
            )
        end
        if ready_for_payment?
            Notification.create!(
                user: insurance_agent,
                title: "A settlement is ready for payment!",
                message: "Click here to make the payment."
            )
            Notification.create!(
                user: attorney,
                title: "A settlement is ready for payment!",
                message: "Click here to request payment."
            )
        end
    end

    def update_ready_for_payment_attribute
        if documents.empty? # If settlement has no documents
            puts "📝📝📝 documents.empty?"
            self.ready_for_payment = false
        elsif documents.rejected.exists? # If settlement has rejected documents
            puts "📝📝📝 documents.rejected.exists?"
            self.ready_for_payment = false
        elsif documents.waiting_for_review.exists? # If settlement has unapproved documents
            puts "📝📝📝 documents.waiting_for_review.exists?"
            self.ready_for_payment = false
        elsif documents.unsigned.need_signature.exists? # If settlement has unsigned documents that should be signed
            puts "📝📝📝 documents.unsigned.need_signature.exists?"
            self.ready_for_payment = false
        elsif !payments.not_sent.exists? # If settlement does not have a payment model ready to execute payment
            puts "📝📝📝 !payments.not_sent.exists?"
            self.ready_for_payment = false
        elsif !documents.first.persisted? # This check was placed here so that ready_for_payment is still false when a document is deleted as a part of a rejection review
            puts "📝📝📝 !documents.first.persisted?"
            self.ready_for_payment = false
        else
            self.ready_for_payment = true
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
        return ready_for_payment
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

    def has_processing_payment?
        return active_payment.processing?
    end

    def has_completed_payment?
        return payments.completed.exists?
    end

    def payment_related_log_entries
        array = []
        array += payments.pluck(:log_book_id) if payments.exists?
        array += payment_requests.pluck(:log_book_id) if payment_requests.exists?
        return LogBookEntry.where(log_book_id: array).all
    end

    def all_log_entries
        array = [log_book_id]
        array += payments.pluck(:log_book_id) if payments.exists?
        array += payment_requests.pluck(:log_book_id) if payment_requests.exists?
        array += documents.pluck(:log_book_id) if documents.exists?
        array += document_reviews.pluck(:log_book_id) if document_reviews.exists?
        return LogBookEntry.where(log_book_id: array).all
    end

    def initiate_payment
        unless locked?
            lock
            self.save
        end
        active_payment.execute_inbound_transfer
    end

    def lock
        self.locked = true;
    end

    def unlock
        self.locked = false;
    end

    def locked?
        locked
    end
end
