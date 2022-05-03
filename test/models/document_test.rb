# == Schema Information
#
# Table name: documents
#
#  id                 :bigint           not null, primary key
#  approved           :boolean          default(FALSE), not null
#  rejected           :boolean          default(FALSE), not null
#  signed             :boolean          default(FALSE), not null
#  uses_wet_signature :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  added_by_id        :bigint
#  ds_envelope_id     :string
#  settlement_id      :bigint
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
require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "fixtures are valid" do
    assert documents.size != 0, "There are no document fixtures to test!"
    documents.each do |d|
      d.settlement = settlements(:false_false_false_false_false)
      assert d.valid?, d.errors.full_messages.inspect
    end
  end

  test "useful test" do

  end
end
