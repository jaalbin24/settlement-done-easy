# == Schema Information
#
# Table name: document_review_log_entries
#
#  id                 :bigint           not null, primary key
#  message            :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  document_review_id :bigint
#  user_id            :bigint
#
# Indexes
#
#  index_document_review_log_entries_on_document_review_id  (document_review_id)
#  index_document_review_log_entries_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (document_review_id => document_reviews.id)
#  fk_rails_...  (user_id => users.id)
#
class DocumentReviewLogEntry < ApplicationRecord
    belongs_to(
        :document_review,
        class_name: "DocumentReview",
        foreign_key: "document_review_id",
        inverse_of: :log_entries
    )

    belongs_to(
        :user,
        class_name: "User",
        foreign_key: "user_id",
        optional: true
    )
end
