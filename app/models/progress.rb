# == Schema Information
#
# Table name: progresses
#
#  id            :integer          not null, primary key
#  stage         :integer          default(1), not null
#  status        :integer          default(1), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  settlement_id :integer
#
# Indexes
#
#  index_progresses_on_settlement_id  (settlement_id)
#
# Foreign Keys
#
#  settlement_id  (settlement_id => settlements.id)
#
class Progress < ApplicationRecord
    # STAGE 1
        # STATUS 1 = Waiting for document upload
        # STATUS 2 = Waiting for approval (Can lead to Stage 1, Status 2 or Stage 1, Status 3)
        # STATUS 3 = Needs adjustment (Can lead to Stage 1, Status 1 or Stage 1, Status 3
        # STATUS 4 = Approved

    # STAGE 2
        # STATUS 1 = Waiting to be sent to claimant
        # STATUS 2 = Waiting for claimant signature
        # STATUS 3 = Approved by claimant (signed)

    # STAGE 3
        # STATUS 1 = Waiting for payment
        # STATUS 2 = Payment received
        # STATUS 5 = Settlement Complete

    belongs_to(
        :settlement,
        class_name: 'Settlement',
        foreign_key: 'settlement_id',
        inverse_of: :progress,
        dependent: :destroy
    )

    def update
        if stage == 1
            if !settlement.hasDocument?
                status = 1
                return
            elsif !settlement.release_form.approved?
                if !settlement.release_form.adjustmentNeeded?
                    status = 2
                else
                    status = 3
                end
            elsif settlement.release_form.approved?
                stage = 2
                status = 1
                return
            end
        elsif stage == 2
            if !settlement.release_form.signed?
                if !settlement.signature_requested?
                    status = 1
                elsif settlement.signature_requested?
                    status = 2
                end
            elsif settlement.release_form.signed?
                stage = 3
                status = 1
            end
        elsif stage == 3
            # This is the payment section. It will be implemented when that feature is.
        elsif stage == 4
            
        end
        self.save
    end
end
