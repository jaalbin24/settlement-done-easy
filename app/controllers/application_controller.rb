class ApplicationController < ActionController::Base
    def sanitize_param(param)
        param.gsub(/([^\w \-\@\.\,])+/, '')
    end
    # This^ is a defense against code injection attacks. Use it for ALL incoming params, and ESPECIALLY those that will be stored in a database.
    def handle_invalid_request
        flash[:error] = "Invalid request"
        redirect_to root_path
    end
end
