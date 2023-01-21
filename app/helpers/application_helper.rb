module ApplicationHelper
    def indefinite_articleize(args=nil)
        if args[:word].nil?
            return
        end
        case args[:html_tag]
        when :strong, "strong"
            return (%w(a e i o u).include?(args[:word][0].downcase) ? "an <strong>#{args[:word]}</strong>" : "a <strong>#{args[:word]}</strong>").html_safe
        end
        return %w(a e i o u).include?(args[:word][0].downcase) ? "an #{args[:word]}" : "a #{args[:word]}"
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
    
    def thumbs_up_icon(args=nil)
        css_classes = ["fa-solid", "fa-thumbs-up", "m-0"]
        return "<i class=\"#{css_classes.join(" ")}\"></i>".html_safe if args.nil?
        case args[:color]
        when :green, :success
            css_classes.push("text-success")
        when :red, :danger
            css_classes.push("text-danger")
        when :grey, :gray
            css_classes.push("text-muted")
        when :primary, :blue
            css_classes.push("text-primary")
        when :yellow, :warning
            css_classes.push("text-warning")
        end
        case args[:size]
        when :h1, :h2, :h3, :h4, :h5, :h6
            css_classes.push(args[:size].to_s)
        end
        css_classes.push("fa-flip-horizontal") if args[:flip_horizontal]
        "<i class=\"#{css_classes.join(" ")}\"></i>".html_safe
    end

    def thumbs_down_icon(args=nil)
        css_classes = ["fa-solid", "fa-thumbs-down", "m-0"]
        return "<i class=\"#{css_classes.join(" ")}\"></i>".html_safe if args.nil?
        case args[:color]
        when :green, :success
            css_classes.push("text-success")
        when :red, :danger
            css_classes.push("text-danger")
        when :grey, :gray
            css_classes.push("text-muted")
        when :primary, :blue
            css_classes.push("text-primary")
        when :yellow, :warning
            css_classes.push("text-warning")
        end
        case args[:size]
        when :h1, :h2, :h3, :h4, :h5, :h6
            css_classes.push(args[:size].to_s)
        end
        css_classes.push("fa-flip-horizontal") if args[:flip_horizontal]
        "<i class=\"#{css_classes.join(" ")}\"></i>".html_safe
    end

    def circle_icon(args=nil)
        css_classes = ["fa-solid", "fa-circle", "m-0"]
        return "<i class=\"#{css_classes.join(" ")}\"></i>".html_safe if args.nil?
        case args[:color]
        when :green, :success
            css_classes.push("text-success")
        when :red, :danger
            css_classes.push("text-danger")
        when :grey, :gray
            css_classes.push("text-muted")
        when :primary, :blue
            css_classes.push("text-primary")
        when :yellow, :warning
            css_classes.push("text-warning")
        end
        case args[:size]
        when :h1, :h2, :h3, :h4, :h5, :h6
            css_classes.push(args[:size].to_s)
        end
        "<i class=\"#{css_classes.join(" ")}\"#{" name=\"#{args[:name]}\"" unless args[:name].nil?}></i>".html_safe
    end

    def checkbox_icon(args=nil)
        css_classes = ["m-0"]
        return "<i class=\"fa-regular #{css_classes.join(" ")}\"></i>".html_safe if args.nil?
        case args[:color]
        when :green, :success
            css_classes.push("text-success")
        when :red, :danger
            css_classes.push("text-danger")
        when :grey, :gray
            css_classes.push("text-muted")
        when :primary, :blue
            css_classes.push("text-primary")
        when :yellow, :warning
            css_classes.push("text-warning")
        end
        case args[:size]
        when :h1, :h2, :h3, :h4, :h5, :h6
            css_classes.push(args[:size].to_s)
        end
        case args[:checked]
        when true
            css_classes.push("fa-square-check")
        when false
            css_classes.push("fa-square")
        end
        case args[:solid]
        when true
            css_classes.push("fa-solid")
        else
            css_classes.push("fa-regular")
        end
        "<i class=\"#{css_classes.join(" ")}\"#{" name=\"#{args[:name]}\"" unless args[:name].nil?}></i>".html_safe
    end

    def chevron_icon(args=nil)
        css_classes = ["m-0", "fa-solid"]
        return "<i class=\"#{css_classes.join(" ")} fa-chevron-right\"></i>".html_safe if args.nil?
        case args[:color]
        when :green, :success
            css_classes.push("text-success")
        when :red, :danger
            css_classes.push("text-danger")
        when :grey, :gray
            css_classes.push("text-muted")
        when :primary, :blue
            css_classes.push("text-primary")
        when :yellow, :warning
            css_classes.push("text-warning")
        end
        case args[:size]
        when :h1, :h2, :h3, :h4, :h5, :h6
            css_classes.push(args[:size].to_s)
        end
        case args[:direction]
        when :right
            css_classes.push("fa-chevron-right")
        when :left
            css_classes.push("fa-chevron-left")
        when :up
            css_classes.push("fa-chevron-up")
        when :down
            css_classes.push("fa-chevron-down")
        else
            css_classes.push("fa-chevron-right") # Default to right-pointing chevron when none specified
        end
        "<i class=\"#{css_classes.join(" ")}\"#{" name=\"#{args[:name]}\"" unless args[:name].nil?}></i>".html_safe
    end

    def warning_icon(args=nil)
        css_classes = ["m-0", "fa-solid"]
        return "<i class=\"#{css_classes.join(" ")} fa-circle-exclamation\"></i>".html_safe if args.nil?
        case args[:color]
        when :green, :success
            css_classes.push("text-success")
        when :red, :danger
            css_classes.push("text-danger")
        when :grey, :gray
            css_classes.push("text-muted")
        when :primary, :blue
            css_classes.push("text-primary")
        when :yellow, :warning
            css_classes.push("text-warning")
        end
        case args[:size]
        when :h1, :h2, :h3, :h4, :h5, :h6
            css_classes.push(args[:size].to_s)
        end
        case args[:shape]
        when :triangle
            css_classes.push("fa-triangle-exclamation")
        else
            css_classes.push("fa-circle-exclamation")
        end
        "<i class=\"#{css_classes.join(" ")}\"#{" name=\"#{args[:name]}\"" unless args[:name].nil?}></i>".html_safe
    end

    def document_icon(args=nil)
        css_classes = ["m-0", "fa-regular", "fa-file-lines"]
        return "<i class=\"#{css_classes.join(" ")}\"></i>".html_safe if args.nil?
        case args[:color]
        when :green, :success
            css_classes.push("text-success")
        when :red, :danger
            css_classes.push("text-danger")
        when :grey, :gray
            css_classes.push("text-muted")
        when :primary, :blue
            css_classes.push("text-primary")
        when :yellow, :warning
            css_classes.push("text-warning")
        end
        case args[:size]
        when :h1, :h2, :h3, :h4, :h5, :h6
            css_classes.push(args[:size].to_s)
        end
        "<i class=\"#{css_classes.join(" ")}\"#{" name=\"#{args[:name]}\"" unless args[:name].nil?}></i>".html_safe
    end
end
