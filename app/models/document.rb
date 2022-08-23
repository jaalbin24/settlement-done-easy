# == Schema Information
#
# Table name: documents
#
#  id              :bigint           not null, primary key
#  auto_generated  :boolean          default(FALSE), not null
#  needs_signature :boolean          default(FALSE), not null
#  signed          :boolean          default(FALSE), not null
#  status          :string           default("Waiting for review"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  added_by_id     :bigint
#  ds_envelope_id  :string
#  settlement_id   :bigint
#
# Indexes
#
#  index_documents_on_added_by_id    (added_by_id)
#  index_documents_on_settlement_id  (settlement_id)
#
# Foreign Keys
#
#  fk_rails_...  (added_by_id => users.id)
#  fk_rails_...  (settlement_id => settlements.id)
#
class Document < ApplicationRecord

    scope :rejected,            ->  {where(status: "Rejected")}
    scope :approved,            ->  {where(status: "Approved")}
    scope :unapproved,          ->  {where(status: "Rejected").or(where(status: "Waiting for review"))}
    scope :waiting_for_review,  ->  {where(status: "Waiting for review")}
    scope :signed,              ->  {where(signed: true)}
    scope :unsigned,            ->  {where(signed: false)}
    scope :need_signature,      ->  {where(needs_signature: true)}
    scope :auto_generated,      ->  {where(auto_generated: true)}


    has_one_attached :pdf

    has_many(
        :comments,
        class_name: 'Comment',
        foreign_key: 'document_id',
        inverse_of: :document,
        dependent: :destroy
    )

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

    has_many(
        :log_entries,
        class_name: "DocumentLogEntry",
        foreign_key: "document_id",
        inverse_of: :document,
        dependent: :destroy
    )

    validates :pdf, presence: true
    validates :status, inclusion: {in: ["Approved", "Rejected", "Waiting for review"]}
    validate :has_exactly_two_reviews
    def has_exactly_two_reviews
        errors.add(:reviews, "must be of size=2") unless reviews.size == 2
    end
    
    before_validation do |document|
        if !document.pdf.attached?
            begin
                document.pdf.attach(io: File.open(Rails.root.join("dummy_document.pdf")), filename: 'dummy_document.pdf')
            rescue
                document.pdf.attach(io: StringIO.new(Prawn::Document.new().render), filename: 'blank_document.pdf')
            end
        end
        # This^ if-statement is only here to allow rails db:seed to run without error. 
        # It should be commented out for all other cases.
        if reviews.size != 2
            # Create document reviews for the two required reviewers (insurance agent and attorney)
            reviews.destroy_all
            attorney = settlement.attorney
            insurance_agent = settlement.insurance_agent

            insurance_agent_review = reviews.build(
                document: document,
                reviewer: insurance_agent
            )
            attorney_review = reviews.build(
                document: document,
                reviewer: attorney
            )

            attorney_review.verdict = "Approved" if added_by == attorney
            insurance_agent_review.verdict = "Approved" if added_by == insurance_agent
        end
    end

    before_save do |document|
        if !self.frozen? # The .frozen? check keeps an error from being thrown when deleting document models
            update_approval_status
            generate_any_logs
            settlement.save
        end
    end

    after_commit do |document|

    end

    def update_approval_status
        if reviews.rejections.exists?
            self.status = "Rejected"
        elsif reviews.approvals.size == reviews.size
            self.status = "Approved"
        else
            self.status = "Waiting for review"
        end
    end

    def generate_any_logs
        if status_changed?
            if approved?
                log_entries.build(
                    message: "Document is 100% approved."
                )
            end
        end
        if self.new_record?
            if auto_generated?
                log_entries.build(
                    user: added_by,
                    message: "#{added_by.full_name} generated a document."
                )
            else
                log_entries.build(
                    user: added_by,
                    message: "#{added_by.full_name} uploaded a document."
                )
            end
        end
        if signed? && signed_changed?
            log_entries.build(
                user: added_by,
                message: "Document has been signed by XXXXXXXXXX",
            )
        end
    end
  
    def pdf_file_name
        name = settlement.claim_number + "_document.pdf"
        return name
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
        return reviews.have_been_reviewed.authored_by(user).exists?
    end

    def has_been_rejected_by?(user)
        return reviews.rejections.authored_by(user).exists?
    end

    def has_been_approved_by?(user)
        return reviews.approvals.authored_by(user).exists?
    end

    def can_be_reviewed_by?(user)
        return reviews.authored_by(user).exists?
    end
end
