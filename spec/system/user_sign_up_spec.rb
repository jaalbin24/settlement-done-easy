require "rails_helper"

RSpec.describe "The sign up page", type: :system do
    include_context "devise"
    # before :context do
    #     @law_firm = create(:law_firm)
    #     @insurance_company = create(:insurance_company)
    #     @attorney = @law_firm.members.first
    #     @adjuster = @insurance_company.members.first
    #     @users = [@law_firm, @insurance_company, @attorney, @adjuster]
    # end
    # after :context do
    #     @users.each do |user|
    #         user.destroy
    #     end
    # end
    
    context "when creating an insurance company account" do
        before :each do
            visit root_path
            click_on "Sign up"
            click_on "Insurance Company"
        end
        it "must have a message saying what account is being created." do
            expect(page).to have_text "You are creating an Insurance Company account. If you want to create a different type of account, click here."
        end
        it "must have a link to the account type select page" do
            find("a.link-dark[href='#{user_type_select_path}']").click
        end
    end
    context "when creating a law firm account" do
        before :each do
            visit root_path
            click_on "Sign up"
            click_on "Law Firm"
        end
        it "must have a message saying what account is being created." do
            expect(page).to have_text "You are creating a Law Firm account. If you want to create a different type of account, click here."
        end
        it "must have a link to the account type select page" do
            find("a.link-dark[href='#{user_type_select_path}']").click
            sleep(0.05)
            expect(current_path).to eq user_type_select_path
        end
    end
    context "after the Sign Up button is clicked" do
        before :each do
            visit root_path
            click_on "Sign up"
            click_on "Law Firm"
        end
        context "and the form was not submitted" do
            before :each do
                find("input[data-test-id='submit_user_sign_up_button']").click
            end
            it "must reenable the Sign Up button after 5 seconds" do
                expect(page).to have_css "input[data-test-id='submit_user_sign_up_button'][value='5 Sign up']:disabled"
                expect(page).to have_css "input[data-test-id='submit_user_sign_up_button'][value='Sign up']:enabled", wait: 6
            end
        end
        context "if the email was blank" do
            before :each do
                fill_in "user[business_name]", with: "Valid Business Name"
                fill_in "user[password]", with: "password123"
                fill_in "user[password_confirmation]", with: "password123"
                find("input[data-test-id='submit_user_sign_up_button']").click
            end
            it "must style the field to be red" do
                expect(page).to have_css "input.form-control.is-invalid[name='user[email]']"
            end
            it "must show a message saying the field cannot be blank" do
                expect(page).to have_css "div.invalid-feedback[data-test-id='user[email]_cannot_be_blank']"
                expect(page).to have_text "Cannot be blank"
            end
        end
        context "if the email was invalid" do
            before :each do
                fill_in "user[business_name]", with: "Valid Business Name"
                fill_in "user[email]", with: "invalid.email@example"
                fill_in "user[password]", with: "password123"
                fill_in "user[password_confirmation]", with: "password123"
                find("input[data-test-id='submit_user_sign_up_button']").click
            end
            it "must style the field to be red" do
                expect(page).to have_css "input.form-control.is-invalid[name='user[email]']"
            end
            it "must show a message saying the email is invalid" do
                expect(page).to have_css "div.invalid-feedback[data-test-id='user[email]_please_enter_a_valid_email']"
                expect(page).to have_text "Please enter a valid email"
            end
        end
        context "if the password was blank" do
            before :each do
                fill_in "user[business_name]", with: "Valid Business Name"
                fill_in "user[email]", with: "valid.email@example.com"
                fill_in "user[password_confirmation]", with: "password123"
                find("input[data-test-id='submit_user_sign_up_button']").click
            end
            it "must style the field to be red" do
                expect(page).to have_css "input.form-control.is-invalid[name='user[password]']"
            end
            it "must show a message saying the field cannot be blank" do
                expect(page).to have_css "div.invalid-feedback[data-test-id='user[password]_cannot_be_blank']"
                expect(page).to have_text "Cannot be blank"
            end
        end
        context "if the password confirmation was blank" do
            before :each do
                fill_in "user[business_name]", with: "Valid Business Name"
                fill_in "user[email]", with: "valid.email@example.com"
                fill_in "user[password]", with: "password123"
                find("input[data-test-id='submit_user_sign_up_button']").click
            end
            it "must style the field to be red" do
                expect(page).to have_css "input.form-control.is-invalid[name='user[password_confirmation]']"
            end
            it "must show a message saying the field cannot be blank" do
                expect(page).to have_css "div.invalid-feedback[data-test-id='user[password_confirmation]_cannot_be_blank']"
                expect(page).to have_text "Cannot be blank"
            end
        end
        context "if the password confirmation did not match the password" do
            before :each do
                fill_in "user[business_name]", with: "Valid Business Name"
                fill_in "user[email]", with: "valid.email@example.com"
                fill_in "user[password]", with: "password123"
                fill_in "user[password_confirmation]", with: "differentPassword123"
                find("input[data-test-id='submit_user_sign_up_button']").click
            end
            it "must style the field to be red" do
                expect(page).to have_css "input.form-control.is-invalid[name='user[password_confirmation]']"
            end
            it "must show a message saying the passwords did not match" do
                expect(page).to have_css "div.invalid-feedback[data-test-id='user[password_confirmation]_does_not_match']"
                expect(page).to have_text "Does not match"
            end
        end
        context "if the organization name was blank" do
            before :each do
                find("input[data-test-id='submit_user_sign_up_button']").click
            end
            it "must style the field to be red" do
                expect(page).to have_css "input.form-control.is-invalid[name='user[business_name]']"
            end
            it "must show a message saying the field cannot be blank" do
                expect(page).to have_css "div.invalid-feedback[data-test-id='user[business_name]_cannot_be_blank']"
                expect(page).to have_text "Cannot be blank"
            end
        end
        context "if the form submits successfully" do
            before :each do
                fill_in "user[business_name]", with: "Valid Business Name"
                fill_in "user[email]", with: "valid.email@example.com"
                fill_in "user[password]", with: "password123"
                fill_in "user[password_confirmation]", with: "password123"
                find("input[data-test-id='submit_user_sign_up_button']").click
            end
            it "must take the user to the requirements page" do
                sleep(0.05)
                expect(current_path).to eq requirements_path
            end
        end
    end
end