# == Schema Information
#
# Table name: settlements
#
#  id                 :integer          not null, primary key
#  claim_number       :string
#  defendent_name     :string
#  incident_date      :date
#  incident_location  :string
#  plaintiff_name     :string
#  policy_number      :string
#  settlement_amount  :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  insurance_agent_id :integer
#  lawyer_id          :integer
#
# Indexes
#
#  index_settlements_on_insurance_agent_id  (insurance_agent_id)
#  index_settlements_on_lawyer_id           (lawyer_id)
#
# Foreign Keys
#
#  insurance_agent_id  (insurance_agent_id => users.id)
#  lawyer_id           (lawyer_id => users.id)
#
class Settlement < ApplicationRecord
    belongs_to(
        :lawyer,
        class_name: "User",
        foreign_key: "lawyer_id",
    )

    belongs_to(
        :insurance_agent,
        class_name: "User",
        foreign_key: "insurance_agent_id",
    )

    has_one(
        :release_form,
        class_name: "ReleaseForm",
        foreign_key: "settlement_id",
        inverse_of: :settlement,
        dependent: :destroy
    )

    # Validate lawyer.role == "Lawyer" and the same for insurance agents

    def partner_of(user)
        if user.isLawyer?
            return insurance_agent
        elsif user.isInsuranceAgent?
            return lawyer
        end
    end
end
