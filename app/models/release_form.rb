# == Schema Information
#
# Table name: release_forms
#
#  id                     :integer          not null, primary key
#  approved_by_lawyer     :boolean          default(FALSE), not null
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
#  status                 :string           default("Reviewable"), not null
#  type                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  insurance_agent_id     :integer
#  lawyer_id              :integer
#
# Indexes
#
#  index_release_forms_on_insurance_agent_id  (insurance_agent_id)
#  index_release_forms_on_lawyer_id           (lawyer_id)
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
        :lawyer,
        class_name: 'User',
        foreign_key: 'lawyer_id',
        inverse_of: :lawyer_owned_release_forms
    )

    belongs_to(
        :insurance_agent,
        class_name: 'User',
        foreign_key: 'insurance_agent_id',
        inverse_of: :insurance_agent_owned_release_forms
    )

    validates :settlement_amount, numericality: true
    validate :settlement_amount_less_than_one_million, :date_of_incident_must_be_in_past, :settlement_amount_has_only_two_decimal_places
    
    validates :claim_number, presence: true
    validates :policy_number, presence: true
    validates :settlement_amount, presence: true
    validates :status, presence: true
    validates :pdf, presence: true

    # before_save do
    #     self.update_status
    # end

    before_validation do
        if !self.pdf.attached?
            self.pdf.attach(io: StringIO.new(Prawn::Document.new().render), filename: 'dummy_file.pdf')
        end 
    end
    # This^ callback is only here to allow rails db:seed to run without error. 
    # It should be commented out for all other cases.

    def status_is_valid
        errors.add(:status, "Status not valid") unless ["waiting_for_review", "waiting_for_adjustments", "waiting_for_approval", "waiting_to_be_sent_to_client", "waiting_for_client_signature", "complete"].include? status
        # waiting_for_review ------------- (default status) form has been sent to lawyer for review
        # waiting_for_adjustments -------- form has been rejected and sent to insurance agent for adjustment. Making adjustments and resending form will trigger status change to waiting_for_review again
        # waiting_to_be_sent_to_client --- form has been approved and is waiting to be sent to client
        # waiting_for_client_signature --- form has been sent to client to be signed
        # complete ----------------------- form has been signed by client
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

    # def update_status
    #     if self.law_firm_name != nil && self.pdf.attached?
    #         self.status = "Ready to send!"
    #     if !self.approved_by_lawyer && !self.adjustment_made_since_
    #         self.status = "Adjustment needed!"
    #     elsif #CONDITION
    #         self.status = "Waiting for approval..."
    #     if self.approved_by_lawyer
    #         self.status = "Approved!"
    #     end
    # end

    def pdf_file_name
        name = self.claim_number + "_release_form.pdf"
        return name
    end
end
