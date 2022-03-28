module SettlementProgress
    # STAGE 1
        # STATUS 1 = Waiting for document upload
        # STATUS 2 = Waiting for document approval (Can lead to Stage 1, Status 2 or Stage 1, Status 3)
        # STATUS 3 = Document needs adjustment (Can lead to Stage 1, Status 1 or Stage 1, Status 3
        # STATUS 4 = Document Approved

    # STAGE 2
        # STATUS 1 = Waiting to be sent to claimant
        # STATUS 2 = Waiting for claimant signature
        # STATUS 3 = Approved by claimant (signed)
        # STATUS 4 = Waiting for final document review

    # STAGE 3
        # STATUS 1 = Waiting for payment
        # STATUS 2 = Paid. Payment processing
        # STATUS 3 = Payment received

    # STAGE 4
        # STATUS 1 = Completed

    def self.statusValid?(stage, status)
        stage = stage.to_i
        status = status.to_i
        if status == nil || stage == nil
            return false
        elsif stage == 1
            if status >= 1 && status <= 4
                return true
            end
        elsif stage == 2
            if status >= 1 && status <= 4
                return true
            end
        elsif stage == 3
            if status >= 1 && status <= 2
                return true
            end
        elsif stage == 4
            if status == 1
                return true
            end
        else
            return false
        end
    end

    def self.need_message(stage, status)
        stage = stage.to_i
        status = status.to_i
        case stage
        when 1
            case status
            when 1
                return "need a document"
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

    def self.status_message(settlement)
        stage = settlement.stage
        status = settlement.status
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
                return "Waiting for #{settlement.lawyer.full_name} to send signature request"
            when 2
                return "Waiting for #{settlement.plaintiff_name}'s signature"
            when 3
                return "Waiting for #{settlement.lawyer.full_name} to review final document"
            end
        when 3
            case status
            when 1
                return "Waiting for #{settlement.insurance_agent.full_name} to add payment"
            when 2
                return "Payment is processing"
            when 3
                return "Payment received! #{settlement.lawyer.full_name} can complete this settlement."
            end
        when 4
            return "Completed"
        end
    end
end