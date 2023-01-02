class UserSettingsController < ApplicationController
    before_action :authenticate_user!

    def update
        if !current_user.settings.update(sanitized_params)
            flash[:primary] = "Settings could not be updated."
            puts "⚠️⚠️⚠️ ERROR: #{current_user.settings.errors.full_messages.inspect}"
            raise StandardError.new "Something stopped the user settings from being updated. Investigate it."
        end
    end

    def sanitized_params
        params.require(:user_settings).permit(
            :replace_unsigned_document_with_signed_document,
            :alert_when_settlement_ready_for_payment,
            :confirmation_before_document_rejection,
            :delete_my_documents_after_rejection,
        )
    end

    def account
        render :account
    end

    def profile
        @user_profile = current_user.profile
        @user = current_user
        @continue_path = params[:continue_path]
        render :profile
    end
end
