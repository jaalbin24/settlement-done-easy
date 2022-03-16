# == Schema Information
#
# Table name: release_forms
#
#  id                     :integer          not null, primary key
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
#  status                 :string           default("Default status"), not null
#  type                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class ReleaseForm < ApplicationRecord
    include ActionView::Helpers::NumberHelper 
    # This^ is included for the number_to_currency method in the settlement_amount_formatted method
    has_one_attached :pdf
    validates :settlement_amount, numericality: true
    validate :settlement_amount_less_than_one_million, :date_of_incident_must_be_in_past, :settlement_amount_has_only_two_decimal_places
    
    validates :claim_number, presence: true
    validates :policy_number, presence: true
    validates :settlement_amount, presence: true
    validates :status, presence: true
    validates :pdf, presence: true

    before_validation do
        if !self.pdf.attached?
            self.pdf.attach(io: StringIO.new(Prawn::Document.new().render), filename: 'dummy_file.pdf')
        end
    end
    
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
   
    def settlement_amount_humanized
        # returns a worded dollar amount   
        dollars = self.settlement_amount.floor
        cents = self.settlement_amount - dollars
        cents *= 100
        cents = cents.round
        humanized = dollars.humanize + " dollars and " + cents.humanize + " cents"
        return humanized
    end

    def settlement_amount_formatted
        return number_to_currency(self.settlement_amount.to_f, delimiter: ',', unit: '$')
    end

    def pdf_file_name
        name = self.claim_number + "_release_form.pdf"
        return name
    end
end
