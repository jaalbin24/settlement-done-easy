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
require "test_helper"

class ReleaseFormTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
