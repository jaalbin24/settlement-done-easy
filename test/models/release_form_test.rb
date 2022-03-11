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
require "test_helper"

class ReleaseFormTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
