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
class DocumentLogEntry < ApplicationRecord
    belongs_to(
        :document,
        class_name: "Document",
        foreign_key: "document_id",
        inverse_of: :log_entries
    )

    belongs_to(
        :user,
        class_name: "User",
        foreign_key: "user_id",
        optional: true
    )
end
