require "rails_helper"

RSpec.describe "The sign up page" do
    include_context "devise"
    # before(:context) do
    #     @law_firm = create(:law_firm)
    #     @insurance_company = create(:insurance_company)
    #     @attorney = @law_firm.members.first
    #     @adjuster = @insurance_company.members.first
    #     @users = [@law_firm, @insurance_company, @attorney, @adjuster]
    # end

    context "after the Sign Up button is clicked" do
        context "if the email was blank" do
            it "must style the field to be red" do
                pending "Implementation"
                fail
            end
            it "must reenable the Sign Up button" do
                pending "Implementation"
                fail
            end
            it "must show a message saying the field cannot be blank" do
                pending "Implementation"
                fail
            end
        end
        context "if the email was invalid" do
            it "must style the field to be red" do
                pending "Implementation"
                fail
            end
            it "must reenable the Sign Up button" do
                pending "Implementation"
                fail
            end
            it "must show a message saying the email is invalid" do
                pending "Implementation"
                fail
            end
        end
        context "if the password was blank" do
            it "must style the field to be red" do
                pending "Implementation"
                fail
            end
            it "must reenable the Sign Up button" do
                pending "Implementation"
                fail
            end
            it "must show a message saying the field cannot be blank" do
                pending "Implementation"
                fail
            end
        end
        context "if the password confirmation was blank" do
            it "must style the field to be red" do
                pending "Implementation"
                fail
            end
            it "must reenable the Sign Up button" do
                pending "Implementation"
                fail
            end
            it "must show a message saying the field cannot be blank" do
                pending "Implementation"
                fail
            end
        end
        context "if the password was less than #{Rails.configure.MINIMUM_PASSWORD_LENGTH} characters" do
            it "must style the field to be red" do
                pending "Implementation"
                fail
            end
            it "must reenable the Sign Up button" do
                pending "Implementation"
                fail
            end
            it "must show a message saying the field cannot be blank" do
                pending "Implementation"
                fail
            end
        end
        context "if the organization name was blank" do
            it "must style the field to be red" do
                pending "Implementation"
                fail
            end
            it "must reenable the Sign Up button" do
                pending "Implementation"
                fail
            end
            it "must show a message saying the field cannot be blank" do
                pending "Implementation"
                fail
            end
        end
        context "if the form submits successfully" do
            it "must queue an ActiveJob to create the user's Stripe account" do
                pending "Implementation"
                fail
            end
            it "must take the user to the requirements page" do
                pending "Implementation"
                fail
            end
        end
    end
end