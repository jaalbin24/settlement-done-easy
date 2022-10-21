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

    def green_checked_box_icon
        `<i class="fa-regular fa-square-check bg-success"></i>`
    end

    def checked_box_icon
        `<i class="fa-regular fa-square-check"></i>`
    end

    def red_unchecked_box_icon
        `<i class="fa-regular fa-square bg-danger"></i>`
    end

    def unchecked_box_icon
        `<i class="fa-regular fa-square"></i>`
    end
    
    def settlements_need_approval(user)
        count = 0
        path = "#"
        user.settlements.each do |s|
            if 1 == 1 && 1 == 2
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
                message = "Documents need approval."
            else
                message = "Document needs approval."
            end
        elsif user.isInsuranceAgent?
            if count != 1
                message = "Documents waiting for approval."
            else
                message = "Document waiting for approval."
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
            if 1 == 2 && 1 == 1
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
                message = "Documents need a signature."
            else
                message = "Document needs a signature."
            end
        elsif user.isInsuranceAgent?
            if count != 1
                message = "Documents waiting for signature."
            else
                message = "Document waiting for signature."
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
            if 1 == 1 && 1 == 3
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
                message = "Documents waiting for adjustment."
            else
                message = "Document waiting for adjustment."
            end
        elsif user.isInsuranceAgent?
            if count != 1
                message = "Documents need adjustment."
            else
                message = "Document needs adjustment."
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
            if 1 == 3 && 1 == 1
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
            if 1 == 1 && 1 == 1
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
            if 1 == 3 && 1 == 2
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
            if 1 == 2 && 1 == 2
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
                message = "Documents waiting for client signature."
            else
                message = "Document waiting for client signature."
            end
        elsif user.isInsuranceAgent?
            if count != 1
                message = "Documents waiting for claimant signature."
            else
                message = "Document waiting for claimant signature."
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
            if 1 == 2 && 1 == 3
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

    def thumbs_up_icon(args=nil)
        css_classes = ["fa-solid", "fa-thumbs-up", "m-0"]
        return "<i class=\"#{css_classes.join(" ")}\"></i>".html_safe if args.nil?
        case args[:color]
        when :green
            css_classes.push("text-success")
        when :red
            css_classes.push("text-danger")
        end
        case args[:text_size]
        when :h1, :h2, :h3, :h4, :h5, :h6
            css_classes.push(args[:text_size].to_s)
        end
        css_classes.push("fa-flip-horizontal") if args[:flip_horizontal]
        "<i class=\"#{css_classes.join(" ")}\"></i>".html_safe
    end

    def thumbs_down_icon(args=nil)
        css_classes = ["fa-solid", "fa-thumbs-down", "m-0"]
        return "<i class=\"#{css_classes.join(" ")}\"></i>".html_safe if args.nil?
        case args[:color]
        when :green
            css_classes.push("text-success")
        when :red
            css_classes.push("text-danger")
        end
        case args[:text_size]
        when :h1, :h2, :h3, :h4, :h5, :h6
            css_classes.push(args[:text_size].to_s)
        end
        css_classes.push("fa-flip-horizontal") if args[:flip_horizontal]
        "<i class=\"#{css_classes.join(" ")}\"></i>".html_safe
    end

    def circle_icon(args=nil)
        css_classes = ["fa-solid", "fa-circle", "m-0"]
        return "<i class=\"#{css_classes.join(" ")}\"></i>".html_safe if args.nil?
        case args[:color]
        when :green
            css_classes.push("text-success")
        when :red
            css_classes.push("text-danger")
        end
        case args[:text_size]
        when :h1, :h2, :h3, :h4, :h5, :h6
            css_classes.push(args[:text_size].to_s)
        end
        "<i class=\"#{css_classes.join(" ")}\"></i>".html_safe
    end
end
