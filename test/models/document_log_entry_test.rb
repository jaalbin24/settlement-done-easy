# == Schema Information
#
# Table name: document_log_entries
#
#  id          :bigint           not null, primary key
#  message     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  document_id :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_document_log_entries_on_document_id  (document_id)
#  index_document_log_entries_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (document_id => documents.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class DocumentLogEntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
