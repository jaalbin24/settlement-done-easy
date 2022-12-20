class MultiFactorAuthenticationController < ApplicationController
    before_action :authenticate_user!

    def disable
        flash[:info] = "MFA is not yet supported on Settlement Done Easy."
        redirect_back(fallback_location: root_path)
    end
end
