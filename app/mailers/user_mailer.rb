class UserMailer < ApplicationMailer

    default from: 'John.Smith29324@gmail.com'
    # Change to Welcome@SettlementDoneEasy.com

    def welcome_email
        @user = params[:user]
        @url  = 'http://example.com/login'
        mail(to: @user.email, subject: 'Welcome to Settlement Done Easy')
    end

    def insurance_new_notification
        @document = params[:generated_release_form]
        mail(to: @document.lawyer.email, subject: 'A New Document is Ready For Review.')
    end

    def insurance_edit_notification
        @document = params[:generated_release_form]
        mail(to: @document.lawyer.email, subject: 'A Revised Document is Ready For Review.')
    end


end
