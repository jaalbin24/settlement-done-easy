class UserMailer < ApplicationMailer

    default from: 'John.Smith29324@gmail.com'
    # Change to Welcome@SettlementDoneEasy.com

    def welcome_email
        @user = params[:user]
        @url  = 'http://example.com/login'
        mail(to: @user.email, subject: 'Welcome to Settlement Done Easy')
    end
end
