module PaymentSafety
    module Settlements
        def safe_to_execute_payment?(settlement)

        end
    end
    
    module Payments
        def safe_to_execute_inbound_transfer?(payment)
            
        end

        def safe_to_execute_outbound_payment?(payment)

        end

        def safe_to_execute_outbound_transfer?(payment)

        end
    end
end