# == Schema Information
#
# Table name: signatures
#
#  id           :bigint           not null, primary key
#  corner1_x    :float
#  corner1_y    :float
#  corner2_x    :float
#  corner2_y    :float
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
class Signature < ApplicationRecord


    belongs_to(
        :document,
        class_name: "Document",
        foreign_key: :document_id,
        inverse_of: :signatures
    )

    after_create do
        # SendElectronicSignatureRequest.perform_later(self)
    end

end
