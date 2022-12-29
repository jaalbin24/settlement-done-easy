require "rails_helper"

RSpec.describe "The sign in page", type: :system do
    include_context "devise"
    before :context do
        @law_firm = create(:law_firm)
        @insurance_company = create(:insurance_company)
        @attorney = @law_firm.members.first
        @adjuster = @insurance_company.members.first
        @users = [@law_firm, @insurance_company, @attorney, @adjuster]
    end
    after :context do
        @users.each do |user|
            user.destroy
        end
    end

    before :each do
        @users.each do |user|
            sign_out
        end
    end
    
    context "after the Sign In button is clicked" do
        context "and the form was not submitted" do
            it "must reenable the Sign In button after 5 seconds" do
                visit new_user_session_path
                find("input[data-test-id='submit_user_sign_in_button']").click
                expect(page).to have_css "input[data-test-id='submit_user_sign_in_button'][value='5 Sign in']:disabled"
                expect(page).to have_css "input[data-test-id='submit_user_sign_in_button'][value='Sign in']:enabled", wait: 6
            end
        end
        context "if the email was blank" do
            it "must style the field to be red and show an error message" do
                visit new_user_session_path
                fill_in "user[password]", with: "password123"
                find("input[data-test-id='submit_user_sign_in_button']").click
                expect(page).to have_css "input.form-control.is-invalid[name='user[email]']"
                expect(page).to have_css "div.invalid-feedback[data-test-id='user[email]_cannot_be_blank']"
                expect(page).to have_text "Cannot be blank"
            end
        end
        context "if the email was invalid" do
            it "must style the field to be red and show an error message" do
                visit new_user_session_path
                fill_in "user[email]", with: "invalid.email@example"
                fill_in "user[password]", with: "password123"
                find("input[data-test-id='submit_user_sign_in_button']").click
                expect(page).to have_css "input.form-control.is-invalid[name='user[email]']"
                expect(page).to have_css "div.invalid-feedback[data-test-id='user[email]_please_enter_a_valid_email']"
                expect(page).to have_text "Please enter a valid email"
            end
        end
        context "if the password was blank" do
            it "must style the field to be red and show an error message" do
                @users.each do |user|
                    visit new_user_session_path
                    fill_in "user[email]", with: user.email
                    find("input[data-test-id='submit_user_sign_in_button']").click
                    expect(page).to have_css "input.form-control.is-invalid[name='user[password]']"
                    expect(page).to have_css "div.invalid-feedback[data-test-id='user[password]_cannot_be_blank']"
                    expect(page).to have_text "Cannot be blank"
                end
            end
        end
        context "when the password is incorrect" do
            it "must show a flash message saying the username or password is incorrect" do
                @users.each do |user|
                    visit new_user_session_path
                    fill_in "user[email]", with: user.email
                    fill_in "user[password]", with: "wrongPassword123"
                    find("input[data-test-id='submit_user_sign_in_button']").click
                    expect(page).to have_css "div.alert.alert-dismissible.alert-danger.border.border-danger"
                    expect(page).to have_text "Username or password incorrect"
                end
            end
        end
        context "when the email is not recognized" do
            it "must show a flash message saying the username or password is incorrect" do
                @users.each do |user|
                    visit new_user_session_path
                    fill_in "user[email]", with: "unknownEmail@example.com"
                    fill_in "user[password]", with: "password123"
                    find("input[data-test-id='submit_user_sign_in_button']").click
                    expect(page).to have_css "div.alert.alert-dismissible.alert-danger.border.border-danger"
                    expect(page).to have_text "Username or password incorrect"
                end
            end
        end
        context "if the form submits successfully" do
            it "must take the user to the root page" do
                @users.each do |user|
                    sign_out
                    visit new_user_session_path
                    fill_in "user[email]", with: user.email
                    fill_in "user[password]", with: "password123"
                    find("input[data-test-id='submit_user_sign_in_button']").click
                    sleep(0.05)
                    expect(current_path).to eq root_path
                end
            end
        end
    end
end