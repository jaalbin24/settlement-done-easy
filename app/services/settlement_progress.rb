module SettlementProgress
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

    def self.status_message(settlement)
        stage = settlement.stage
        status = settlement.status
        case stage
        when 1
            case status
            when 1
                return "Waiting for document to be added."
            when 2
                return "Waiting for document review."
            when 3
                return "Document rejected. Waiting for new document upload."
            end
        when 2
            case status
            when 1
                return "Waiting for #{settlement.attorney.full_name} to send signature request."
            when 2
                return "Waiting for #{settlement.plaintiff_name}'s signature."
            when 3
                return "Waiting for final document review."
            end
        when 3
            case status
            when 1
                return "Waiting for #{settlement.insurance_agent.full_name} to make payment."
            when 2
                return "Payment processing."
            when 3
                return "Error with payment."
            when 4
                return "Payment received! #{settlement.attorney.full_name} can now complete this settlement."
            end
        when 4
            return "Completed"
        end
    end

    # Checks if progress change agrees with the settlement workflow.
    def self.progress_change_valid?(settlement, desired_stage, desired_status)
        case desired_stage
        when 1
            case desired_status
            when 1
                if settlement.stage == 1
                    return true
                end
            when 2
                if settlement.stage == 1 && (settlement.status == 1 || settlement.status == 3)
                    return true
                end
            when 3
                if settlement.stage == 1 && settlement.status == 2
                    return true
                end
            end
        when 2
            case desired_status
            when 1
                if settlement.stage == 1 && (settlement.status == 2 || settlement.status == 3)
                    return true
                end
            when 2
                if settlement.stage == 2 && settlement.status == 1
                    return true
                end
            when 3
                if settlement.stage == 2 && settlement.status == 2
                    return true
                end
            end
        when 3
            case desired_status
            when 1
                if settlement.stage == 2 && settlement.status == 3
                    return true
                end
            when 2
                if settlement.stage == 3 && settlement.status == 1
                    return true
                end
            when 3
                if settlement.stage == 3 && settlement.status == 2
                    return true
                end
            when 4
                if settlement.stage == 3 && (settlement.status == 2 || settlement.status == 3)
                    return true
                end
            end
        when 4
            if settlement.stage == 3 && settlement.status == 3
                return true
            end
        end
        puts "=================== Progress change from (stage #{settlement.stage}, status #{settlement.status}) to (stage #{desired_stage}, status #{desired_status}) is not valid."
        return false
    end
end
