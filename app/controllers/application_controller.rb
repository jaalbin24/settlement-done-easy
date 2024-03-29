class ApplicationController < ActionController::Base
    before_action :continue_path
    def continue_path
        @continue_path = params[:continue_path] unless params[:continue_path].blank?
    end



    def sanitize_param(param)
        param.gsub(/([^\w \-\@\.\,])+/, '')
    end
    # This^ is a defense against code injection attacks. Use it for ALL incoming params, and ESPECIALLY those that will be stored in a database.
    def handle_invalid_request
        flash[:primary] = "Invalid request"
        if params[:continue_path].nil?
            redirect_to root_path
        else
            redirect_to params[:continue_path]
        end
    end
end
