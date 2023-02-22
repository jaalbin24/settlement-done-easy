# == Schema Information
#
# Table name: documents
#
#  id              :bigint           not null, primary key
#  auto_generated  :boolean
#  needs_signature :boolean
#  nickname        :string
#  signed          :boolean
#  status          :string           default("Waiting for review"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  added_by_id     :bigint
#  ds_envelope_id  :string
#  log_book_id     :bigint
#  public_id       :string
#  settlement_id   :bigint
#
# Indexes
#
#  index_documents_on_added_by_id    (added_by_id)
#  index_documents_on_log_book_id    (log_book_id)
#  index_documents_on_settlement_id  (settlement_id)
#
# Foreign Keys
#
#  fk_rails_...  (added_by_id => users.id)
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (settlement_id => settlements.id)
#
class Document < ApplicationRecord

    scope :rejected,            ->      {where(status: "Rejected")}
    scope :approved,            ->      {where(status: "Approved")}
    scope :unapproved,          ->      {where(status: "Rejected").or(where(status: "Waiting for review"))}
    scope :waiting_for_review,  ->      {where(status: "Waiting for review")}
    scope :signed,              ->      {where(signed: true)}
    scope :unsigned,            ->      {where(signed: false)}
    scope :needs_signature,     ->      {where(needs_signature: true)}
    scope :auto_generated,      ->      {where(auto_generated: true)}
    scope :added_by,            ->  (i) {where(added_by: i)}

    scope :needs_approval_from, ->  (i) {joins(:reviews).merge(DocumentReview.by(i).waiting_for_review).distinct}
    scope :belonging_to,        ->  (i) {joins(:settlement).where(settlement: {attorney: i}).or(where(settlement: {adjuster: i})).distinct}


    has_one_attached :pdf
    has_one_attached :html
    has_many_attached :pages # Images of the PDFs pages

    has_many(
        :reviews,
        class_name: "DocumentReview",
        foreign_key: "document_id",
        inverse_of: :document,
        dependent: :destroy
    )

    belongs_to(
        :settlement,
        class_name: 'Settlement',
        foreign_key: 'settlement_id',
        inverse_of: :documents,
    )

    belongs_to(
        :added_by,
        class_name: 'User',
        foreign_key: 'added_by_id',
    )

    belongs_to(
        :log_book,
        class_name: "LogBook",
        foreign_key: "log_book_id",
        dependent: :destroy,
        optional: true
    )

    validates :pdf, presence: true
    validates :status, inclusion: {in: -> (i) {Document.statuses}}
    validates :added_by, presence: true
    validate :has_exactly_two_reviews
    def has_exactly_two_reviews
        errors.add(:reviews, "must be of size = 2") unless reviews.size == 2
    end

    validate :changes_are_allowed_when_settlement_is_locked
    def changes_are_allowed_when_settlement_is_locked
        if settlement.locked? && !new_record?
            changed_attributes.keys.each do |a|
                unless Document.attributes_that_can_be_changed_when_settlement_is_locked.include?(a.to_sym)
                    raise SafetyError::DocumentSafetyError.new "This settlement is locked. You cannot modify its documents."
                end
            end
        end
    end
    def self.attributes_that_can_be_changed_when_settlement_is_locked
        []
    end
    
    before_validation do
        puts "❤️❤️❤️ Document before_validation block"
        unless pdf.attached?
            begin
                pdf.attach(io: File.open(Rails.root.join("dummy_document.pdf")), filename: 'dummy_document.pdf')
            rescue
                pdf.attach(io: StringIO.new(Prawn::Document.new().render), filename: 'blank_document.pdf')
            end
        end
        # This^ if-statement is only here to allow rails db:seed to run without error. 
        # It should be commented out for all other cases.
       
        if reviews.size != 2
            # Create document reviews for the two required reviewers (adjuster and attorney)
            reviews.destroy_all

            reviews.build(
                reviewer: settlement.adjuster
            )
            reviews.build(
                reviewer: settlement.attorney
            )
        end
        self.status = "Waiting for review" if status.blank?
    end

    before_save do 
        puts "❤️❤️❤️ Document before_save block"
        unless log_book.nil?
            generate_any_logs
            log_book.save
        end
    end

    before_create do
        puts "❤️❤️❤️ Document before_create block"
        create_log_book_model_if_self_lacks_one
        init_nickname
        if settlement.locked?
            raise SafetyError::DocumentSafetyError.new "You cannot add documents to this settlement right now because it is locked."
        end
    end

    after_commit do
        puts "❤️❤️❤️ Document after_commit block"
        unless frozen? # The .frozen? check keeps an error from being thrown when deleting models
            update_status_attribute
            if changed?
                self.save
            end
            # if will_be_deleted_after_rejection? && rejected?
            #     self.destroy
            # end
        end
        settlement.save
    end

    after_create do
        ConvertPdfToImageJob.perform_later self
    end

    def self.statuses
        ["Approved", "Rejected", "Waiting for review"]
    end

    def update_status_attribute
        if reviews.rejections.exists?
            reject
        elsif reviews.approvals.count == reviews.count
            approve
        else
            self.status = "Waiting for review"
        end
    end

    def reject
        self.status = "Rejected"
    end

    def approve
        self.status = "Approved"
    end

    def generate_any_logs
        if status_changed?
            if approved?
                log_book.entries.build(
                    message: "Document #{filename} is 100% approved."
                )
            end
        end
        if self.new_record?
            if auto_generated?
                log_book.entries.build(
                    user: added_by,
                    message: "#{added_by.name} generated a document."
                )
            else
                log_book.entries.build(
                    user: added_by,
                    message: "#{added_by.name} uploaded a document."
                )
            end
        end
        if signed? && signed_changed?
            log_book.entries.build(
                user: added_by,
                message: "Document has been signed by XXXXXXXXXX",
            )
        end
    end

    def create_log_book_model_if_self_lacks_one
        self.log_book = LogBook.create! if log_book.nil?
    end
  
    def filename
        if pdf.attached?
            pdf.filename.base.to_s
        else
            "new_release"
        end
        "HTML_FILE"
    end

    def rejected?
        return status == "Rejected"
    end

    def approved?
        return status == "Approved"
    end

    def signed?
        return signed
    end

    def auto_generated?
        return auto_generated
    end

    def needs_signature?
        return needs_signature
    end

    def has_been_reviewed_by?(user)
        return reviews.have_been_reviewed.by(user).exists?
    end

    def has_been_rejected_by?(user)
        return reviews.rejections.by(user).exists?
    end

    def has_been_approved_by?(user)
        return reviews.approvals.by(user).exists?
    end

    def waiting_for_review_by?(user)
        return reviews.waiting_for_review.by(user).exists?
    end

    def init_nickname
        self.nickname = "Release for #{settlement.claimant_name}"
    end

    def sent_signature?
        ds_envelope_id.blank?
    end
end
