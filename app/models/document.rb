# == Schema Information
#
# Table name: documents
#
#  id                     :bigint           not null, primary key
#  adjustment_needed      :boolean          default(FALSE), not null
#  approved               :boolean          default(FALSE), not null
#  claim_number           :string
#  date_of_incident       :date
#  defendant_name         :string
#  incident_description   :string
#  insurance_company_name :string           default("Default Insurance Co. (FAKE! USED FOR TESTING PURPOSES!)"), not null
#  law_firm_name          :string           default("Default Law Firm (FAKE! USED FOR TESTING PURPOSES!)"), not null
#  place_of_incident      :string
#  plaintiff_name         :string
#  policy_number          :string
#  settlement_amount      :float            default(0.0), not null
#  signed                 :boolean          default(FALSE), not null
#  type                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  ds_envelope_id         :string
#  settlement_id          :bigint
#
# Indexes
#
#  index_documents_on_settlement_id  (settlement_id)
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
        inverse_of: :document,
    )

    validate :settlement_amount_less_than_one_million, :date_of_incident_must_be_in_past, :settlement_amount_has_only_two_decimal_places
    validates :pdf, presence: true

    # before_save do
    #     self.update_status
    # end

    after_save do
        settlement.save
    end

    before_validation do
        if !self.pdf.attached?
            begin
                self.pdf.attach(io: File.open(Rails.root.join("dummy_document.pdf")), filename: 'dummy_document.pdf')
            rescue
                self.pdf.attach(io: StringIO.new(Prawn::Document.new().render), filename: 'blank_dummy_dummy.pdf')
            end
        end 
    end
    # This^ callback is only here to allow rails db:seed to run without error. 
    # It should be commented out for all other cases.

    def settlement_amount_less_than_one_million
        if settlement_amount != nil
            errors.add(:settlement_amount, "Must be less than one million") unless settlement_amount <= 1000000
        end
    end

    def settlement_amount_has_only_two_decimal_places
        if settlement_amount != nil
            errors.add(:settlement_amount, "Can only have two decimal places") unless settlement_amount.round(2) == settlement_amount
        end
    end
    
    def date_of_incident_must_be_in_past
        if date_of_incident != nil
            errors.add(:date_of_incident, "Must be before today") unless date_of_incident < Date.today
        end
    end

    def settlement_amount_formatted
        return number_to_currency(self.settlement_amount.to_f, delimiter: ',', unit: '$')
    end

    def pdf_file_name
        name = settlement.claim_number + "_document.pdf"
        return name
    end

    def approved?
        return approved
    end

    def adjustmentNeeded?
        return adjustment_needed
    end

    def signed?
        return signed
    end
end
