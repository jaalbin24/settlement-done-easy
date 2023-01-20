# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    def new
        self.resource = resource_class.new(sign_in_params)
        clean_up_passwords(resource)
        yield resource if block_given?
        respond_with(resource, serialize_options(resource))
    end

    # POST /resource/sign_in
    def create
        self.resource = warden.authenticate!(auth_options)
        # set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?
        if current_user.isMember?
            flash[:primary] = {
                heading: "Welcome back, #{resource.profile.first_name}!",
                message: "You are now signed in."
            }
        elsif resource.activated?
            flash[:primary] = {
                heading: "Welcome back, #{resource.business_name}!",
                message: "You are now signed in."
            }
        else
            flash[:warning] = {
                heading: "Account not activated",
                message: "You have signed in, but your account is not activated. Click <a href=\"#{requirements_path}\" class=\"alert-link\">here</a> to activate your account."
            }
        end
        respond_with resource, location: after_sign_in_path_for(resource)
    end

    def redirect_on_failed_sign_in
        flash[:danger] = "Username or password incorrect"
        redirect_to new_user_session_path(sign_in_params)
    end

    # DELETE /resource/sign_out
    # def destroy
    #     super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #     devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end

    def auth_options
        { scope: resource_name, recall: "#{controller_path}#redirect_on_failed_sign_in" }
    end
end
