# == Schema Information
#
# Table name: release_forms
#
#  id                     :integer          not null, primary key
#  claim_number           :string           default("XXXXCLAIMXXXX"), not null
#  date_of_incident       :date             default(Mon, 01 Jan 1900), not null
#  defendant_name         :string           default("David Default Defendant"), not null
#  incident_description   :string           default("an incident"), not null
#  insurance_company_name :string           default("Fake Insurance Co."), not null
#  law_firm_name          :string           default("Fake Law Firm"), not null
#  place_of_incident      :string           default("Gotham City"), not null
#  plaintiff_name         :string           default("Peter Pretend Plaintiff"), not null
#  policy_number          :string           default("XXXPOLICYXXX"), not null
#  settlement_amount      :float            default(0.0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require "test_helper"

class ReleaseFormTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
