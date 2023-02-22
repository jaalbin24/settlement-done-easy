# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    def new
        # This unless block is here because free-use accounts should not be advertised when they do not exist.
        self.resource = resource_class.new(sign_in_params)
        clean_up_passwords(resource)
        yield resource if block_given?
        flash.now[:info] = {
            heading: "You can use these login credentials.",
            message: '
            <p class="m-0">Settlement Done Easy is currently unfinished. Until it is complete, the following emails will be available for anyone wanting to explore the site.</p>
            <ul class="my-2">
                <li>
                    <span class="fw-bold">attorney0@example.com</span> will log you in as an attorney.
                </li>
                <li>
                    <span class="fw-bold">adjuster0@example.com</span> will log you in as an adjuster.
                </li>
                <li>
                    <span class="fw-bold">law_firm0@example.com</span> will log you in as a law firm.
                </li>
                <li>
                    <span class="fw-bold">insurance_company0@example.com</span> will log you in as an insurance company.
                </li>
            </ul>
            <p class="m-0">All passwords are \'<span class="fw-bold">password123</span>\'</p>
            '
        } if User.where(email: "attorney0@example.com").count != 0
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
                heading: "Welcome back, #{helpers.sanitize resource.profile.first_name}!",
                message: "You are now signed in."
            }
        elsif resource.activated?
            flash[:primary] = {
                heading: "Welcome back, #{helpers.sanitize resource.name}!",
                message: "You are now signed in."
            }
        else
            flash[:warning] = {
                heading: "Your account is not activated.",
                message: "You have signed in, but your account is not activated. Click <a href=\"#{user_profile_show_path(current_user.profile, section: 'requirements')}\" class=\"alert-link\">here</a> to activate your account."
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

    # If you have extra params to permit, append them to the helpers.sanitizer.
    # def configure_sign_in_params
    #     devise_parameter_helpers.sanitizer.permit(:sign_in, keys: [:attribute])
    # end

    def auth_options
        { scope: resource_name, recall: "#{controller_path}#redirect_on_failed_sign_in" }
    end
end
