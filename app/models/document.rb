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
class Document < ApplicationRecord
    include ActionView::Helpers::NumberHelper 
    # This^ is included for the number_to_currency method in the settlement_amount_formatted method
    has_one_attached :pdf

    has_many(
        :comments,
        class_name: 'Comment',
        foreign_key: 'document_id',
        inverse_of: :document,
        dependent: :destroy
    )

    belongs_to(
        :settlement,
        class_name: 'Settlement',
        foreign_key: 'settlement_id',
        inverse_of: :documents,
        autosave: true
    )

    belongs_to(
        :added_by,
        class_name: 'User',
        foreign_key: 'added_by_id',
    )

    validates :pdf, presence: true
    
    before_validation do
        if !self.pdf.attached?
            begin
                self.pdf.attach(io: File.open(Rails.root.join("dummy_document.pdf")), filename: 'dummy_document.pdf')
            rescue
                self.pdf.attach(io: StringIO.new(Prawn::Document.new().render), filename: 'blank_document.pdf')
            end
        end 
    end
    # This^ callback is only here to allow rails db:seed to run without error. 
    # It should be commented out for all other cases.
    after_commit do
        settlement.save
    end
    
    def pdf_file_name
        name = settlement.claim_number + "_document.pdf"
        return name
    end

    def approved?
        return approved
    end

    def signed?
        return signed
    end
end
