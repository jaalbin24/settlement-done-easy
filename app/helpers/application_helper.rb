module ApplicationHelper
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
      "primary" => "alert-primary"
    }
    bootstrap_alert_class[level]
  end

  def status_action_path(settlement)
    status = settlement.progress.status
    case settlement.progress.stage
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
end
