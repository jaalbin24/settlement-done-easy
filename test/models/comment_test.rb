# == Schema Information
#
# Table name: comments
#
#  id              :integer          not null, primary key
#  content         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  release_form_id :integer
#
# Indexes
#
#  index_comments_on_release_form_id  (release_form_id)
#
# Foreign Keys
#
#  release_form_id  (release_form_id => release_forms.id)
#
require "test_helper"

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
