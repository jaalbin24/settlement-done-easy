# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @role = params[:role]
    if @role == "Adjuster"
      @organizations = User.all_insurance_companies
    elsif @role == "Attorney"
      @organizations = User.all_law_firms
    elsif @role == "Law Firm" || @role == "Insurance Company"
      @organizations = nil
    else
      redirect_to user_type_select_url
      return
    end
    super
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    if resource.organization_id == -1
      resource.organization_id = nil
    end
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        if resource.activated?
          # TODO: Send yourself an email because this should never happen. A user is activated as soon as they sign up? Something's fishy.
        else
          flash[:warning] = "You have signed up, but your account is not activated. Click <a href=\"#{requirements_path}\" class=\"alert-link\">here</a> to activate your account.".html_safe
        end
        # set_flash_message! :notice, :signed_up # Equivalent to flash[:notice] = "[whatever the signup message is]"
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      resource.errors.full_messages.each do |message|
        flash.now[:alert] = message
      end
      clean_up_passwords resource
      set_minimum_password_length
      @role = params[:user][:role]
      # if @role == "Adjuster"
      #   @organizations = User.all_insurance_companies
      # elsif @role == "Attorney"
      #   @organizations = User.all_law_firms
      # elsif @role == "Law Firm" || @role == "Insurance Company"
      #   @organizations = nil
      # else
      #   redirect_to user_type_select_url
      #   return
      # end
      respond_with resource
    end
  end

  # GET /resource/edit
  def edit
    if current_user.isMember?
      render :edit_member
    elsif current_user.isOrganization?
      render :edit_organization
    end
  end

  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
      respond_with resource, location: after_update_path_for(resource)
    else
      flash[:info] = "Account details could not be updated at this time. Please try again later."
      clean_up_passwords resource
      set_minimum_password_length
      redirect_to settings_url
    end
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end


  # GET /users/validate
  def validate_password
    puts "================================> current_password: #{params["user[current_password]"]}"
    if current_user.valid_password?(params["user[current_password]"])
      head 200
    else
      head 401
    end
  end

  def cancel_changes
    flash[:info] = "No changes were made."
    if params[:continue_path].nil?
      redirect_to root_path
    else
      redirect_to params[:continue_path]
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_with_password(params)
  end

  # If you have extra params to permit, append them to the sanitizer in the keys array.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :first_name, :last_name, :organization_id, :business_name])
  end

  # If you have extra params to permit, append them to the sanitizer in the keys array.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone_number, :first_name, :last_name, :organization_id, :business_name])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end

  # The default url to be used after updating a resource. You need to overwrite
  # this method in your own RegistrationsController.
  def after_update_path_for(resource)
    if sign_in_after_change_password?
      if params[:continue_path].blank?
        settings_path
      else
        continue_path
      end
    else
      new_session_path(resource_name)
    end
  end
end
