module ApplicationHelper
    def indefinite_articleize(word)
        %w(a e i o u).include?(word[0].downcase) ? "an #{word}" : "a #{word}"
    end
    
    def active_class(path)
        if request.path == path
            return 'active'
        else
            return ''
        end
    end

    def flash_class(level)
        bootstrap_alert_class = {
            "success" => "alert-success",
            "error" => "alert-danger",
            "danger" => "alert-danger",
            "info" => "alert-info",
            "alert" => "alert-danger",
            "warning" => "alert-warning",
            "secondary" => "alert-secondary",
            "primary" => "alert-primary",
            "notice" => "alert-info"
        }
        bootstrap_alert_class[level]
    end

    # Used for the status link on the settlement show that can lead anywhere depending on the status of a settlement.
    def status_action_path(settlement)
        status = settlement.status
        case settlement.stage
        when 1
            case status
            when 1
                return document_new_path(settlement)
            when 2
                return settlement_review_document_path(settlement)
            when 3
                return document_new_path(settlement)
            end
        when 2
            case status
            when 1
                return document_get_e_signature_path(settlement.document_that_needs_signature)
            when 2
                return document_get_ds_envelope_status_path(settlement.document_with_signature_request)
            when 3
                return settlement_review_final_document_path(settlement)
            end
        when 3
            case status
            when 1
                return stripe_settlement_checkout_session_path(settlement)
            when 2
                return stripe_get_payment_status_path(settlement)
            when 3
                return "#"
            when 4
                return settlement_complete_path(settlement)
            end
        when 4
            return "#"
        end
    end

    def settlements_need_approval(user)
        count = 0
        path = "#"
        user.settlements.each do |s|
            if s.stage == 1 && s.status == 2
                path = settlement_show_path(s)
                count += 1
            end
        end
        if count > 0
            if user.isAttorney?
                bg = 'danger'
            elsif user.isInsuranceAgent?
                bg = 'warning'
            end
        else
            bg = 'primary'
        end
        if user.isAttorney?
            if count != 1
                message = "Settlements need approval."
            else
                message = "Settlement needs approval."
            end
        elsif user.isInsuranceAgent?
            if count != 1
                message = "Settlements waiting for approval."
            else
                message = "Settlement waiting for approval."
            end
        end
        if count != 0 && count != 1
            path = settlement_need_index_path(stage = 1, status = 2)
        end
        return "<a href='#{path}' class='list-group-item list-group-item-action d-flex align-items-center'>
                    <span class='badge bg-#{bg} rounded-pill' style='width: 2rem; margin-right: 0.5rem;'>#{count}</span>
                    #{message}
                </a>".html_safe
    end

    def settlements_ready_to_be_signed(user)
        count = 0
        path = "#"
        user.settlements.each do |s|
            if s.stage == 2 && s.status == 1
                path = settlement_show_path(s)
                count += 1
            end
        end
        if count > 0
            if user.isAttorney?
                bg = 'danger'
            elsif user.isInsuranceAgent?
                bg = 'warning'
            end
        else
            bg = 'primary'
        end
        if user.isAttorney?
            if count != 1
                message = "Settlements need a signature request."
            else
                message = "Settlement needs a signature request."
            end
        elsif user.isInsuranceAgent?
            if count != 1
                message = "Settlements waiting to be sent to claimant."
            else
                message = "Settlement waiting to be sent to claimant."
            end
        end
        if count != 0 && count != 1
            path = settlement_need_index_path(stage = 2, status = 1)
        end
        return "<a href='#{path}' class='list-group-item list-group-item-action d-flex align-items-center'>
                    <span class='badge bg-#{bg} rounded-pill' style='width: 2rem; margin-right: 0.5rem;'>#{count}</span>
                    #{message}
                </a>".html_safe
    end

    def settlements_need_adjustment(user)
        count = 0
        path = "#"
        user.settlements.each do |s|
            if s.stage == 1 && s.status == 3
                path = settlement_show_path(s)
                count += 1
            end
        end
        if count > 0
            if user.isInsuranceAgent?
                bg = 'danger'
            elsif user.isAttorney?
                bg = 'warning'
            end
        else
            bg = 'primary'
        end
        if user.isAttorney?
            if count != 1
                message = "Settlements waiting for adjustment."
            else
                message = "Settlement waiting for adjustment."
            end
        elsif user.isInsuranceAgent?
            if count != 1
                message = "Settlements need adjustment."
            else
                message = "Settlement needs adjustment."
            end
        end
        if count != 0 && count != 1
            path = settlement_need_index_path(stage = 3, status = 1)
        end
        return "<a href='#{path}' class='list-group-item list-group-item-action d-flex align-items-center'>
                    <span class='badge bg-#{bg} rounded-pill' style='width: 2rem; margin-right: 0.5rem;'>#{count}</span>
                    #{message}
                </a>".html_safe
    end

    def settlements_need_payment(user)
        count = 0
        path = "#"
        user.settlements.each do |s|
            if s.stage == 3 && s.status == 1
                path = settlement_show_path(s)
                count += 1
            end
        end
        if count > 0
            if user.isInsuranceAgent?
                bg = 'danger'
            elsif user.isAttorney?
                bg = 'warning'
            end
        else
            bg = 'primary'
        end
        if user.isAttorney?
            if count != 1
                message = "Settlements waiting for payment."
            else
                message = "Settlement waiting for payment."
            end
        elsif user.isInsuranceAgent?
            if count != 1
                message = "Settlements need payment."
            else
                message = "Settlement needs payment."
            end
        end
        if count != 0 && count != 1
            path = settlement_need_index_path(stage = 3, status = 1)
        end
        return "<a href='#{path}' class='list-group-item list-group-item-action d-flex align-items-center'>
                    <span class='badge bg-#{bg} rounded-pill' style='width: 2rem; margin-right: 0.5rem;'>#{count}</span>
                    #{message}
                </a>".html_safe
    end

    def settlements_need_document(user)
        count = 0
        path = "#"
        user.settlements.each do |s|
            if s.stage == 1 && s.status == 1
                path = settlement_show_path(s)
                count += 1
            end
        end
        if count > 0
            if user.isInsuranceAgent?
                bg = 'danger'
            elsif user.isAttorney?
                bg = 'warning'
            end
        else
            bg = 'primary'
        end
        if user.isAttorney?
            if count != 1
                message = "Settlements waiting for a document."
            else
                message = "Settlement waiting for a document."
            end
        elsif user.isInsuranceAgent?
            if count != 1
                message = "Settlements need a document."
            else
                message = "Settlement needs a document."
            end
        end
        if count != 0 && count != 1
            path = settlement_need_index_path(stage = 1, status = 1)
        end
        return "<a href='#{path}' class='list-group-item list-group-item-action d-flex align-items-center'>
                    <span class='badge bg-#{bg} rounded-pill' style='width: 2rem; margin-right: 0.5rem;'>#{count}</span>
                    #{message}
                </a>".html_safe
    end

    def settlements_need_payment_review(user)
        count = 0
        path = "#"
        user.settlements.each do |s|
            if s.stage == 3 && s.status == 2
                path = settlement_show_path(s)
                count += 1
            end
        end
        if count > 0
            if user.isAttorney?
                bg = 'danger'
            elsif user.isInsuranceAgent?
                bg = 'warning'
            end
        else
            bg = 'primary'
        end
        if user.isAttorney?
            if count != 1
                message = "Payments need review."
            else
                message = "Payment needs review."
            end
        elsif user.isInsuranceAgent?
            if count != 1
                message = "Payments waiting for review."
            else
                message = "Payment waiting for review."
            end
        end
        if count != 0 && count != 1
            path = settlement_need_index_path(stage = 3, status = 2)
        end
        return "<a href='#{path}' class='list-group-item list-group-item-action d-flex align-items-center'>
                    <span class='badge bg-#{bg} rounded-pill' style='width: 2rem; margin-right: 0.5rem;'>#{count}</span>
                    #{message}
                </a>".html_safe
    end

    def settlements_need_signature(user)
        count = 0
        path = "#"
        user.settlements.each do |s|
            if s.stage == 2 && s.status == 2
                path = settlement_show_path(s)
                count += 1
            end
        end
        if count > 0
            bg = 'warning'
        else
            bg = 'primary'
        end
        if user.isAttorney?
            if count != 1
                message = "Settlements waiting for client signature."
            else
                message = "Settlement waiting for client signature."
            end
        elsif user.isInsuranceAgent?
            if count != 1
                message = "Settlements waiting for claimant signature."
            else
                message = "Settlement waiting for claimant signature."
            end
        end
        if count != 0 && count != 1
            path = settlement_need_index_path(stage = 2, status = 2)
        end
        return "<a href='#{path}' class='list-group-item list-group-item-action d-flex align-items-center'>
                    <span class='badge bg-#{bg} rounded-pill' style='width: 2rem; margin-right: 0.5rem;'>#{count}</span>
                    #{message}
                </a>".html_safe
    end

    def settlements_need_final_approval
        count = 0
        path = "#"
        current_user.settlements.each do |s|
            if s.stage == 2 && s.status == 3
                path = settlement_show_path(s)
                count += 1
            end
        end
        if count > 0
            if current_user.isAttorney?
                bg = 'danger'
            elsif current_user.isInsuranceAgent?
                bg = 'warning'
            end
        else
            bg = 'primary'
        end
        if current_user.isAttorney?
            if count != 1
                message = "Settlements need final approval."
            else
                message = "Settlement needs final approval."
            end
        elsif current_user.isInsuranceAgent?
            if count != 1
                message = "Settlements waiting for final approval."
            else
                message = "Settlement waiting for final approval."
            end
        end
        if count != 0 && count != 1
            path = settlement_need_index_path(stage = 2, status = 3)
        end
        return "<a href='#{path}' class='list-group-item list-group-item-action d-flex align-items-center'>
                    <span class='badge bg-#{bg} rounded-pill' style='width: 2rem; margin-right: 0.5rem;'>#{count}</span>
                    #{message}
                </a>".html_safe
    end

    def need_message(stage, status)
        message = "These settlements "
        case stage
        when 1
            case status
            when 1
                if current_user.isAttorney?
                    message += "are waiting for an insurance agent to add a document."
                elsif current_user.isInsuranceAgent?
                    message += "need a document to continue."
                end
            when 2
                if current_user.isAttorney?
                    message += "need your approval to continue."
                elsif current_user.isInsuranceAgent?
                    message += "are waiting for approval from a attorney."
                end
            when 3
                if current_user.isAttorney?
                    message += "are waiting for an insurance agent to make adjustments."
                elsif current_user.isInsuranceAgent?
                    message += "need your adjustments to continue."
                end
            end
        when 2
            case status
            when 1
                if current_user.isAttorney?
                    message += "need a signature request sent to your client."
                elsif current_user.isInsuranceAgent?
                    message += "are waiting for a claimant's signature."
                end
            when 2
                if current_user.isAttorney?
                    message += "are waiting for a client's signature."
                elsif current_user.isInsuranceAgent?
                    message += "are waiting for a claimant's signature."
                end
            when 3
                if current_user.isAttorney?
                    message += "need your approval to continue."
                elsif current_user.isInsuranceAgent?
                    message += "are waiting for final document review from a attorney."
                end
            end
        when 3
            case status
            when 1
                if current_user.isAttorney?
                    message += "are waiting for payment."
                elsif current_user.isInsuranceAgent?
                    message += "are ready for payment."
                end
            when 2
                if current_user.isAttorney?
                    message += "are waiting for payment."
                elsif current_user.isInsuranceAgent?
                    message += "are ready for payment."
                end
            when 3
                return "MESSAGE NOT YET IMPLEMENTED. Go to application_helpers.rb"
            end
        when 4
            return "have been completed!"
        end    
    end
end
