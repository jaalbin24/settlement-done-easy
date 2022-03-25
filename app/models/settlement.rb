# == Schema Information
#
# Table name: settlements
#
#  id                  :integer          not null, primary key
#  claim_number        :string
#  defendent_name      :string
#  incident_date       :date
#  incident_location   :string
#  plaintiff_name      :string
#  policy_number       :string
#  settlement_amount   :float
#  signature_requested :boolean          default(FALSE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  insurance_agent_id  :integer
#  lawyer_id           :integer
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
    )

    has_one(
        :progress,
        class_name: "Progress",
        foreign_key: "settlement_id",
        inverse_of: :settlement
    )

    before_destroy do
        release_form.destroy unless release_form == nil
        progress.destroy
    end

    after_save do
        progress.update
    end

    before_create do
        progress = self.build_progress
    end

    def partner_of(user)
        if user.isLawyer?
            return insurance_agent
        elsif user.isInsuranceAgent?
            return lawyer
        end
    end

    def hasDocument?
        if release_form == nil
            return false
        elsif !release_form.pdf.attached?
            return false
        else
            return true
        end
    end

    def status_message
        return progress.status_message
    end
end
