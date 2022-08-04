class PagesController < ApplicationController
    before_action :authenticate_user!, except: :user_type_select

    def user_type_select
        render :user_type_select
    end

    def generate_or_upload
        render :generate_or_upload
    end

    def approve_or_reject
        @document = Document.find(params[:id])
        @comment = Comment.new
        render :approve_or_reject
    end

    def root
        if current_user.isOrganization?
            if !current_user.stripe_account_id.nil?
                @external_accounts = Stripe::Account.list_external_accounts(current_user.stripe_account_id).data
            end
            render :organization_dashboard
        else
            render :member_dashboard
        end
    end

    def testing
        render :testing
    end
end
