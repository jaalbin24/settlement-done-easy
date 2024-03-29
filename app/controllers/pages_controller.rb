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
        else
            redirect_to user_profile_show_path(current_user.profile)
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

    def cancel_changes
        flash[:primary] = "No changes were made."
        if params[:continue_path].blank?
            redirect_to root_path
        else
            redirect_to params[:continue_path]
        end
    end
end
