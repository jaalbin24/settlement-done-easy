class PagesController < ApplicationController
    before_action :authenticate_user!, except: [:user_type_select, :root]

    def user_type_select
        render :user_type_select
    end

    def generate_or_upload
        render :generate_or_upload
    end

    def approve_or_reject
        @document = Document.find_by!(public_id: params[:id])
        render :approve_or_reject
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

    def testing
        render :testing
    end

    def settings
        if current_user.isOrganization?
            render :org_settings
        else
            render :mem_settings
        end
    end

    def requirements
        if current_user.isOrganization?
            @activation_progress = 0
            @activation_progress += 1 if current_user.stripe_account.onboarded?
            @activation_progress += 1 if current_user.has_bank_account?
            @activation_progress += 1 if current_user.has_member_account?
            @activation_progress += 1 if current_user.two_factor_authentication_enabled?
            @activation_progress += 1 if current_user.email_verified?
            @activation_progress = @activation_progress * 100 / 5
            render :requirements
        else
            flash[:info] = "You cannot access that page."
            redirect_to root_path
        end
    end
end
