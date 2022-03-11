# == Schema Information
#
# Table name: release_forms
#
#  id                     :integer          not null, primary key
#  claim_number           :string
#  date_of_incident       :date
#  defendant_name         :string
#  incident_description   :string
#  insurance_company_name :string
#  law_firm_name          :string
#  place_of_incident      :string
#  plaintiff_name         :string
#  policy_number          :string
#  settlement_amount      :float
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class ReleaseForm < ApplicationRecord
    def settlement_amount_humanized
        return settlement_amount.humanize
    end

    def generate_pdf
        pdf = Prawn::Document.new
        pdf.text = "Known by all these presents that I/we, #{self.defendant_name}, for and in consideration of the sum of #{self.settlement_amount_humanized} ($#{self.settlement_amount}) do hereby for myself my heirs, executors, administrators, successors and assignees any and all other persons, firms, employers, corporations, associations or partnerships, release, acquit and forever discharge #{self.defendent_name} and #{self.insurance_company_name} of and from any and all claims, actions, causes of actions, liens, demands, rights, damages, costs, loss of wages, expenses, and compensation, hospital and medical expenses, accrued or un-accrued claims loss of consortium, loss of support of affection, loss of services, loss of society and companionship, wrongful death on account of, or in any way growing out of, any and all known and unknown personal injuries and other damages resulting from #{self.incident_description} which occurred on or about #{self.date_of_incident}, at #{self.location_of_incident}. However, this release in no way discharges or releases any claim for property damage including rental coverage if applicable."
        return pdf
    end
end
