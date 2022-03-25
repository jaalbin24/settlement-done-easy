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
end
