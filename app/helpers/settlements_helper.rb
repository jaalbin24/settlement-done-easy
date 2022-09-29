module SettlementsHelper
    def payment_confirmation_button_tooltip_message_for(settlement)
        if @settlement.ready_for_payment?
            "A confirmation window will open"
        elsif @settlement.completed?
            "Settlement completed"
        else 
            "Complete checklist first"
        end
    end
end
