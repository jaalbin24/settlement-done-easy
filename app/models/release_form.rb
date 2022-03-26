# == Schema Information
#
# Table name: release_forms
#
#  id                     :integer          not null, primary key
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
#  settlement_id          :integer
#
# Indexes
#
#  index_release_forms_on_settlement_id  (settlement_id)
#
class ReleaseForm < ApplicationRecord
    include ActionView::Helpers::NumberHelper 
    # This^ is included for the number_to_currency method in the settlement_amount_formatted method
    has_one_attached :pdf

    has_many(
        :comments,
        class_name: 'Comment',
        foreign_key: 'release_form_id',
        inverse_of: :release_form,
        dependent: :destroy
    )

    belongs_to(
        :settlement,
        class_name: 'Settlement',
        foreign_key: 'settlement_id',
        inverse_of: :release_form,
    )

    validates :settlement_amount, numericality: true
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
            self.pdf.attach(io: StringIO.new(Prawn::Document.new().render), filename: 'dummy_file.pdf')
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
