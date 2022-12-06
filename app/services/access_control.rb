module AccessControl

    def self.access_authorized_for?(user, accessed_item)
        case accessed_item.class.name.demodulize
        when "Payment"
            if user.settlements.includes(accessed_item.settlement)
                return true
            end
        else
            return false
        end
    end

end