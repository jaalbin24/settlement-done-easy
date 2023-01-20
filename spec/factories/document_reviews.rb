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
#  public_id   :string
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
FactoryBot.define do
    factory :document_review, class: "DocumentReview" do
        document
        verdict {"Waiting"}
        trait :for_approval do
            verdict {"Approved"}
        end
        trait :for_rejection do
            verdict {"Approved"}
        end
        factory :document_review_by_attorney do
            association :reviewer, factory: :attorney
        end

        factory :document_review_by_adjuster do
            association :reviewer, factory: :adjuster
        end
    end
end