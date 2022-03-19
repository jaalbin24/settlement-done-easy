class UserMailer < ApplicationMailer

    default from: 'John.Smith29324@gmail.com'
    # Change to Welcome@SettlementDoneEasy.com

    def welcome_email
        @user = params[:user]
        @url  = 'http://example.com/login'
        mail(to: @user.email, subject: 'Welcome to Settlement Done Easy')
    end

    def lawyer_approve_notification
        @document= params[:release_form]
        mail(to: @document.insurance_agent.email, subject: 'A document has been approved.')
    end

    def lawyer_reject_notification
        @comment = params[:comment]
        mail(to: @comment.rf.insurance_agent.email, subject: 'A document has been rejected.')
    end
end
