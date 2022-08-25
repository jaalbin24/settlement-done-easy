# == Schema Information
#
# Table name: document_reviews
#
#  id          :bigint           not null, primary key
#  reason      :string
#  verdict     :string           default("Waiting"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  document_id :bigint
#  log_book_id :bigint
#  reviewer_id :bigint
#
# Indexes
#
#  index_document_reviews_on_document_id  (document_id)
#  index_document_reviews_on_log_book_id  (log_book_id)
#  index_document_reviews_on_reviewer_id  (reviewer_id)
#
# Foreign Keys
#
#  fk_rails_...  (document_id => documents.id)
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (reviewer_id => users.id)
#
class DocumentReview < ApplicationRecord
    
    scope :approvals,           ->          {where(verdict: "Approved")}
    scope :unapproved,          ->          {where.not(verdict: "Approved")}
    scope :rejections,          ->          {where(verdict: "Rejected")}
    scope :waiting_for_review,  ->          {where(verdict: "Waiting")}
    scope :authored_by,         ->  (user)  {where(reviewer: user)}
    scope :for_document,        ->  (doc)   {where(document: doc)}
    scope :have_been_reviewed,  ->          {where(verdict: "Approved").or(where(verdict: "Rejected"))}

    validates :verdict, inclusion: {in: ["Approved", "Rejected", "Waiting"]}
    validate :reviewer_is_affiliated_with_document
    def reviewer_is_affiliated_with_document
        errors.add(:reviewer, "must be affiliated with this document's settlement.") unless document.settlement.in?(reviewer.settlements)
    end

    belongs_to(   
        :document,
        class_name: "Document",
        foreign_key: "document_id",
        inverse_of: :reviews
    )

    belongs_to(
        :reviewer,
        class_name: "User",
        foreign_key: "reviewer_id",
        inverse_of: :document_reviews
    )

    belongs_to(
        :log_book,
        class_name: "LogBook",
        foreign_key: "log_book_id",
        dependent: :destroy,
        optional: true
    )

    after_save do
        if !self.frozen? # The .frozen? check keeps an error from being thrown when deleting settlement models
            if !document.save
                puts "⚠️⚠️⚠️ ERROR: #{document.errors.full_messages.inspect}"
                raise ActiveRecord::Rollback
            end
        end
    end

    before_save do
        create_log_book_model_if_self_lacks_one
        generate_any_logs
        log_book.save!
    end

    def generate_any_logs
        if verdict_changed?
            if is_for_approval?
                log_book.entries.build(
                    user: reviewer,
                    message: "#{reviewer.full_name} approved a document."
                )
            elsif is_for_rejection?
                log_book.entries.build(
                    user: reviewer,
                    message: "#{reviewer.full_name} rejected a document."
                )
            elsif waiting_for_review?
                log_book.entries.build(
                    user: reviewer,
                    message: "#{reviewer.full_name} unapproved a document."
                )
            end
        end
    end

    def create_log_book_model_if_self_lacks_one
        self.log_book = LogBook.create! if log_book.nil?
    end

    def approve
        self.verdict = "Approved"
        return self.save
    end

    def reject
        self.verdict = "Rejected"
        return self.save
    end

    def unreject
        if self.is_for_approval?
            return false
        end
        self.verdict = "Waiting"
        return self.save
    end

    def waiting_for_review?
        return verdict == "Waiting"
    end

    def is_for_approval?
        return verdict == "Approved"
    end

    def is_for_rejection?
        return verdict == "Rejected"
    end
end
