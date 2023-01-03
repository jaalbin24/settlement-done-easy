# == Schema Information
#
# Table name: settlements
#
#  id                 :bigint           not null, primary key
#  amount             :float
#  claim_number       :string
#  claimant_name      :string
#  completed          :boolean          default(FALSE), not null
#  incident_date      :date
#  incident_location  :string
#  locked             :boolean          default(FALSE), not null
#  policy_holder_name :string
#  policy_number      :string
#  public_number      :integer
#  ready_for_payment  :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  adjuster_id        :bigint
#  attorney_id        :bigint
#  log_book_id        :bigint
#  public_id          :string
#  started_by_id      :bigint
#
# Indexes
#
#  index_settlements_on_adjuster_id    (adjuster_id)
#  index_settlements_on_attorney_id    (attorney_id)
#  index_settlements_on_log_book_id    (log_book_id)
#  index_settlements_on_started_by_id  (started_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (adjuster_id => users.id)
#  fk_rails_...  (attorney_id => users.id)
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (started_by_id => users.id)
#
class Settlement < ApplicationRecord
    include DocumentGenerator

    scope :ready_for_payment,           ->      {where(ready_for_payment: true)}

    validates :amount, presence: true
    validates :locked, inclusion: {in: [true], message: "must be true when the settlement is completed.", if: :completed?}
    validates :locked, inclusion: {in: [true], message: "must be true when the settlement has a processing payment.", if: :has_processing_payment?}
    validates :locked, inclusion: {in: [true], message: "must be true when the settlement has a completed payment.", if: :has_completed_payment?}
    validates :locked, inclusion: {in: [false], message: "must be false when the settlement has no documents.", if: -> (s) {s.documents.empty?}}
    validates :ready_for_payment, inclusion: {in: [false], if: :completed?}

    validate :changes_are_allowed_when_settlement_is_locked
    def changes_are_allowed_when_settlement_is_locked
        if locked?
            changed_attributes.keys.each do |a|
                puts "=========>>>> a=#{a}"
                unless Settlement.attributes_that_can_be_changed_when_settlement_is_locked.include?(a.to_sym)
                    raise SafetyError::SafetyError.new "This settlement cannot be modified right now because it is locked. No changes were made."
                end
            end
        end
    end
    def self.attributes_that_can_be_changed_when_settlement_is_locked
        [:ready_for_payment, :updated_at, :locked, :completed]
    end

    validate :one_or_less_active_payment
    def one_or_less_active_payment
        errors.add(:payments, "can only have one active payment at a time.") unless payments.active.size <= 1
    end

    validate :amount_is_above_allowed_threshold
    def amount_is_above_allowed_threshold
        unless amount.nil?
            errors.add(:amount, "must be greater than $#{Rails.configuration.PAYMENT_MINIMUM_IN_DOLLARS}") unless amount > Rails.configuration.PAYMENT_MINIMUM_IN_DOLLARS
        end
    end
    
    validate :amount_is_below_allowed_threshold
    def amount_is_below_allowed_threshold
        unless amount.nil?
            errors.add(:amount, "must be less than $#{Rails.configuration.PAYMENT_MAXIMUM_IN_DOLLARS}") unless amount < Rails.configuration.PAYMENT_MAXIMUM_IN_DOLLARS
        end
    end
    
    # Assumes reliably incrementing primary key
    validate :completed_payment_must_be_latest_payment
    def completed_payment_must_be_latest_payment
        if payments.completed.exists?
            errors.add(:payments, "is invalid. Completed payment must be the most recent payment.") unless payments.completed.first.created_at >= payments.last.created_at
        end
    end

    belongs_to(
        :started_by,
        class_name: "User",
        foreign_key: :started_by_id
    )

    has_many(
        :settings,
        class_name: "SettlementSettings",
        foreign_key: :settlement_id,
        inverse_of: :settlement,
        dependent: :destroy
    )

    belongs_to(
        :attorney,
        class_name: "User",
        foreign_key: "attorney_id",
        inverse_of: :a_settlements
    )

    belongs_to(
        :adjuster,
        class_name: "User",
        foreign_key: "adjuster_id",
        inverse_of: :ia_settlements
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

    has_many(
        :attribute_reviews,
        class_name: "SettlementAttributesReview",
        foreign_key: :settlement_id,
        inverse_of: :settlement,
        dependent: :destroy
    )

    before_save do
        puts "❤️❤️❤️ Settlement before_save block"
        unless log_book.nil?
            generate_any_logs
            log_book.save
        end
        update_attribute_reviews
        generate_any_notifications
    end

    after_commit do
        puts "❤️❤️❤️ Settlement after_commit block"
        unless frozen? # The .frozen? check keeps an error from being thrown when deleting models
            update_ready_for_payment_attribute
            update_locked_attribute
            update_completed_attribute
            if changed?
                self.save
            end
        end
        active_payment.save unless active_payment.nil?
    end

    before_create do
        puts "❤️❤️❤️ Settlement before_create block"
        create_log_book_model_if_self_lacks_one
        build_default_payment
        build_settings
        build_attribute_reviews
        init_public_number
        self.started_by = attorney if started_by.nil?
    end

    # Public number is assigned by generating a random integer 1-9999. If that number is already assigned to a settlement used by the attorney or adjuster, a different
    # number will be assigned by iterating either forward or backwards from that first number until an unused number is found.
    def init_public_number
        unacceptable_nums = Settlement.where(adjuster: adjuster).or(Settlement.where(attorney: attorney)).and(Settlement.where(completed: false)).pluck(:public_number)
        pn = rand(1..9999)
        counter = 0
        asc_or_desc = [-1, 1].sample
        while unacceptable_nums.include?(pn) && counter < 20 do
            if pn < 1 || pn > 9999
                pn = rand(1..9999)
            end
            pn += asc_or_desc
            counter += 1
        end
        self.public_number = pn
    end

    def self.reviewable_attributes
        [:claimant_name, :policy_holder_name, :policy_number, :claim_number, :incident_date, :incident_location, :amount]
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
        return payments.processing.exists?
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
        # This begin-rescue block ensures the settlement gets unlocked again if the settlement fails to start for some reason.
        begin
            active_payment.execute_inbound_transfer
        rescue => e
            unlock
            self.save
            raise e
        end
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

    def settings_for(user)
        settings.for_user(user).first
    end

    def partner_of(user)
        if user.isAttorney?
            adjuster
        else
            attorney
        end
    end

    private

    def build_default_payment
        if payments.empty?
            payments.build(
                source: adjuster.organization.default_bank_account,
                destination: attorney.organization.default_bank_account,
                amount: amount
            )
        end
    end

    def build_attribute_reviews
        if attribute_reviews.empty?
            attribute_reviews.build(
                reviewer: attorney
            )
            attribute_reviews.build(
                reviewer: adjuster
            )
        end
    end

    def build_settings
        if settings.empty?
            settings.build(
                user: attorney
            )
            settings.build(
                user: adjuster
            )
        end
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
                user: adjuster,
                title: "New Settlement!",
                message: "A new settlement was started with #{attorney.name}. Click here to view it."
            )
            Notification.create!(
                user: attorney,
                title: "New Settlement!",
                message: "A new settlement was started with #{adjuster.name}. Click here to view it."
            )
        end
        if ready_for_payment?
            Notification.create!(
                user: adjuster,
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

    def update_completed_attribute
        if has_completed_payment?
            self.completed = true
        else
            self.completed = false
        end
    end

    def update_attribute_reviews
        Settlement.reviewable_attributes.each do |reviewable_attr|
            if attribute_changed?(reviewable_attr) && !new_record?
                reformatted_attribute = (reviewable_attribute.to_s + "_approved").to_sym
                attribute_reviews.by(current_user).write_attribute(reformatted_attribute, true)
                attribute_reviews.not_by(current_user).write_attribute(reformatted_attribute, false)
            end
        end
    end

    def update_ready_for_payment_attribute
        if documents.first.nil? # If settlement has no documents
            self.ready_for_payment = false
        elsif documents.rejected.exists? # If settlement has rejected documents
            self.ready_for_payment = false
        elsif documents.waiting_for_review.exists? # If settlement has unapproved documents
            self.ready_for_payment = false
        elsif documents.unsigned.need_signature.exists? # If settlement has unsigned documents that should be signed
            self.ready_for_payment = false
        elsif !payments.not_sent.exists? # If settlement does not have a payment model ready to execute payment
            self.ready_for_payment = false
        elsif !documents.first.persisted? # This check was placed here so that ready_for_payment is still false when the last document is deleted as a part of a rejection review
            self.ready_for_payment = false
        elsif has_processing_payment?
            self.ready_for_payment = false
        elsif has_completed_payment?
            self.ready_for_payment = false
        elsif !attorney.organization.activated?
            self.ready_for_payment = false
        elsif !adjuster.organization.activated?
            self.ready_for_payment = false
        else
            self.ready_for_payment = true
        end
    end

    def update_locked_attribute
        if has_processing_payment? ||
            has_completed_payment? ||
            has_unanswered_payment_request? ||
            completed?
            self.locked = true
        end
    end
end
