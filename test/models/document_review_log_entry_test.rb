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
require "test_helper"

class DocumentReviewLogEntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
