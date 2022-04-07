# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  content     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  document_id :integer
#  user_id     :integer
#
# Indexes
#
#  index_comments_on_document_id  (document_id)
#  index_comments_on_user_id      (user_id)
#
# Foreign Keys
#
#  document_id  (document_id => documents.id)
#  user_id      (user_id => users.id)
#
class Comment < ApplicationRecord
  belongs_to(
    :document,
    class_name: 'Document',
    foreign_key: 'document_id',
    inverse_of: :comments
  )

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: 'user_id',
    inverse_of: :comments
  )
  
  validates :content, :author, presence: true

end
