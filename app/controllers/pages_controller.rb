class PagesController < ApplicationController
    before_action :authenticate_user!, except: [:user_type_select, :root, :under_construction]

    def user_type_select
        render :user_type_select
    end

    def generate_or_upload
        render :generate_or_upload
    end

    def root
        if !user_signed_in?
            render :home
        elsif current_user.isOrganization?
            @payments = current_user.payments
            render :organization_dashboard
        elsif current_user.isMember?
            render :member_dashboard
        else
            render :home
        end
    end

    def under_construction
        if params[:page_name].blank?
            @page_name = "That page"
        else
            @page_name = "The #{params[:page_name]} page"
        end
        if params[:continue_path].blank?
            @continue_path = root_path
            @button_label = "Go home"
        else
            @continue_path = params[:continue_path]
            @button_label = "Go back"
        end
        render :under_construction
    end

    def settings
        redirect_to account_settings_url
    end

    def requirements
        if current_user.isOrganization?
            @activation_progress = 0
            @activation_progress += 1 if current_user.stripe_account_onboarded?
            @activation_progress += 1 if current_user.has_bank_account?
            @activation_progress += 1 if current_user.has_member_account?
            @activation_progress += 1 if current_user.two_factor_authentication_enabled?
            @activation_progress += 1 if current_user.email_verified?
            @activation_progress = @activation_progress * 100 / 5
            render :requirements
        else
            flash[:primary] = "You cannot access the requirements page."
            redirect_to root_path
        end
    end
end
