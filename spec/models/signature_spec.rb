# == Schema Information
#
# Table name: signatures
#
#  id           :bigint           not null, primary key
#  corner1_x    :integer
#  corner1_y    :integer
#  corner2_x    :integer
#  corner2_y    :integer
#  signer_email :string
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  document_id  :bigint
#  public_id    :string
#
# Indexes
#
#  index_signatures_on_document_id  (document_id)
#
# Foreign Keys
#
#  fk_rails_...  (document_id => documents.id)
#
require 'rails_helper'

RSpec.describe Signature, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
