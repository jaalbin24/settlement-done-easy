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
        # STATUS 2 = Waiting for document approval (Can lead to Stage 1, Status 2 or Stage 1, Status 3)
        # STATUS 3 = Document needs adjustment (Can lead to Stage 1, Status 1 or Stage 1, Status 3
        # STATUS 4 = Document Approved

    # STAGE 2
        # STATUS 1 = Waiting to be sent to claimant
        # STATUS 2 = Waiting for claimant signature
        # STATUS 3 = Approved by claimant (signed)

    # STAGE 3
        # STATUS 1 = Waiting for payment
        # STATUS 2 = Payment received

    # STAGE 4
        # STATUS 1 = Completed

    belongs_to(
        :settlement,
        class_name: 'Settlement',
        foreign_key: 'settlement_id',
        inverse_of: :progress,
        dependent: :destroy
    )

    def status_action_path(settlement)
        status = settlement.progress.status
        case settlemenet.progress.stage
        when 1
            case status
            when 1
                return release_form_new_path(settlement)
            when 2
                return approve_or_reject_path(settlement.release_form)
            when 3
                return release_form_new_path(settlement)
            end
        when 2
            case status
            when 1
                return "#"
            when 2
                return "#"
            when 3
                return "#"
            end
        when 3
            case status
            when 1
                return "#"
            when 2
                return "#"
            when 3
                return "#"
            end
        when 4
            return "#"
        end
    end

    def status_message
        case stage
        when 1
            case status
            when 1
                return "Waiting for #{settlement.insurance_agent.full_name} to upload documents"
            when 2
                return "Waiting for #{settlement.lawyer.full_name} to review documents"
            when 3
                return "Waiting for #{settlement.insurance_agent.full_name} to adjust documents"
            end
        when 2
            case status
            when 1
                return "Waiting for signature request to be sent"
            when 2
                return "Waiting for signature"
            when 3
                return "Waiting for final document review"
            end
        when 3
            case status
            when 1
                return "Waiting for payment"
            when 2
                return ""
            when 3
                return ""
            end
        when 4
            return "Completed"
        end
    end

    def update
        if stage == 1
            if !settlement.hasDocument?
                self.status = 1
            elsif !settlement.release_form.approved?
                if !settlement.release_form.adjustmentNeeded?
                    self.status = 2
                else
                    self.status = 3
                end
            elsif settlement.release_form.approved?
                self.stage = 2
                self.status = 1
            end
        elsif stage == 2
            if !settlement.release_form.signed?
                if !settlement.signature_requested?
                    self.status = 1
                elsif settlement.signature_requested?
                    self.status = 2
                end
            elsif settlement.release_form.signed?
                self.status = 3
                if settlement.finalApproved?
                    self.stage = 3
                    self.status = 1
                end
            end
        elsif stage == 3
            # This is the payment section. It will be implemented when that feature is.
        elsif stage == 4
            
        end
        if !self.save
            puts "================== PROGRESS MODEL ERROR: #{self.errors.full_messages.inspect}"
        end
    end
end
