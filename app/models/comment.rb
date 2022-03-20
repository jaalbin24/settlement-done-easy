# == Schema Information
#
# Table name: comments
#
#  id              :integer          not null, primary key
#  content         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  release_form_id :integer
#  user_id         :integer
#
# Indexes
#
#  index_comments_on_release_form_id  (release_form_id)
#  index_comments_on_user_id          (user_id)
#
# Foreign Keys
#
#  release_form_id  (release_form_id => release_forms.id)
#  user_id          (user_id => users.id)
#
class Comment < ApplicationRecord
  belongs_to(
    :release_form,
    class_name: 'ReleaseForm',
    foreign_key: 'release_form_id',
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
