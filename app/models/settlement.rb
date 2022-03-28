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
#  stage               :integer          default(1), not null
#  status              :integer          default(1), not null
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

    before_destroy do
        release_form.destroy unless release_form == nil
    end

    after_commit do
        if !self.frozen? # The .frozen? check keeps an error from being thrown when deleting settlement models
            self.update_progress
            if self.changed?
                self.save
            end
        end
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
        return SettlementProgress.status_message(self)
    end

    def update_progress
        if stage == 1
            if !hasDocument?
                self.status = 1
            elsif !release_form.approved?
                if !self.release_form.adjustmentNeeded?
                    self.status = 2
                else
                    self.status = 3
                end
            elsif release_form.approved?
                self.stage = 2
                self.status = 1
            end
        elsif stage == 2
            if !release_form.signed?
                if !signature_requested?
                    self.status = 1
                elsif signature_requested?
                    self.status = 2
                end
            elsif release_form.signed?
                self.status = 3
                if finalApproved?
                    self.stage = 3
                    self.status = 1
                end
            end
        elsif stage == 3
            # This is the payment section. It will be implemented when that feature is.
        elsif stage == 4
            
        end
    end
end
