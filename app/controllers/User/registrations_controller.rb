# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @role = params[:role]
    if @role == "Insurance Agent"
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
        set_flash_message! :notice, :signed_up # Equivalent to flash[:notice] = "[whatever the signup message is]"
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
      if @role == "Insurance Agent"
        @organizations = User.all_insurance_companies
      elsif @role == "Attorney"
        @organizations = User.all_law_firms
      elsif @role == "Law Firm" || @role == "Insurance Company"
        @organizations = nil
      else
        redirect_to user_type_select_url
        return
      end
      respond_with resource
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
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

  # protected

  # If you have extra params to permit, append them to the sanitizer in the keys array.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :first_name, :last_name, :organization_id, :business_name])
  end

  # If you have extra params to permit, append them to the sanitizer in the keys array.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:role, :first_name, :last_name, :organization_id, :business_name])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end


end
