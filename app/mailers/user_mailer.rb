class UserMailer < ApplicationMailer

    default from: 'John.Smith29324@gmail.com'
    # Change to Welcome@SettlementDoneEasy.com

    def welcome_email
        @user = params[:user]
        @url  = 'http://example.com/login'
        mail(to: @user.email, subject: 'Welcome to Settlement Done Easy')
    end

    def insurance_new_notification
        @user = params[:user]
        mail(to: @user.email, subject: 'A New Document is Ready For Review.')
    end

    def insurance_edit_notification
        @user = params[:user]
        mail(to: @user.email, subject: 'A Revised Document is Ready For Review.')
    end

    def lawyer_approve_notification
        @user = params[:user]
        mail(to: @user.email, subject: 'A document has been approved.')
    end

    def lawyer_reject_notification
        @user = params[:user]
        mail(to: @user.email, subject: 'A document has been rejected.')
    end
end
