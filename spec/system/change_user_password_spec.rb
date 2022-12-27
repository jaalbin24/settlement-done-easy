require "rails_helper"

RSpec.describe "The change password page" do
    include_context "devise"
    before(:context) do
        @law_firm = create(:law_firm)
        @insurance_company = create(:insurance_company)
        @attorney = @law_firm.members.first
        @adjuster = @insurance_company.members.first
        @users = [@law_firm, @insurance_company, @attorney, @adjuster]
    end
    it "must have a field to enter the user's current password" do
        @users.each do |user|
            sign_in user
            visit change_password_path
            expect(page).to have_css "input.form-control[name='user[current_password]']"
        end
    end
    it "must have a field to enter the new password" do
        @users.each do |user|
            sign_in user
            visit change_password_path
            expect(page).to have_css "input.form-control[name='user[password]']"
        end
    end
    it "must have a field to enter the new password again" do
        @users.each do |user|
            sign_in user
            visit change_password_path
            expect(page).to have_css "input.form-control[name='user[password_confirmation]']"
        end
    end
    it "must have a button labeled 'Save'" do
        @users.each do |user|
            sign_in user
            visit change_password_path
            expect(page).to have_css "input[data-test-id='submit_change_password_button'][value='Save']"
        end
    end
    context "after the 'Save' button is pressed" do
        context "if the current password was blank" do
            it "must style the current password input field red" do
                @users.each do |user|
                    sign_in user
                    visit change_password_path
                    fill_in "user[password]", with: "password1234"
                    fill_in "user[password_confirmation]", with: "password1234"
                    click_on "Save"
                    expect(page).to have_css "input.form-control.is-invalid[name='user[current_password]']"
                end
            end
            it "must reenable the 'Save' button" do
                @users.each do |user|
                    sign_in user
                    visit change_password_path
                    fill_in "user[password]", with: "password1234"
                    fill_in "user[password_confirmation]", with: "password1234"
                    click_on "Save"
                    expect(page).to have_css "input[data-test-id='submit_change_password_button'][value='Save']:enabled"
                end
            end
            it "must show a message saying the password cannot be blank" do
                @users.each do |user|
                    sign_in user
                    visit change_password_path
                    fill_in "user[password]", with: "password1234"
                    fill_in "user[password_confirmation]", with: "password1234"
                    click_on "Save"
                    expect(page).to have_css "div.invalid-feedback"
                    expect(page).to have_text "Cannot be blank"
                end
            end
        end
        context "if the new password was blank" do
            it "must style the password input field red" do
                @users.each do |user|
                    sign_in user
                    visit change_password_path
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "input.form-control.is-invalid[name='user[password]']"
                end
            end
            it "must reenable the 'Save' button" do
                @users.each do |user|
                    sign_in user
                    visit change_password_path
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "input[data-test-id='submit_change_password_button'][value='Save']:enabled"
                end
            end
            it "must show a message saying the password cannot be blank" do
                @users.each do |user|
                    sign_in user
                    visit change_password_path
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "div.invalid-feedback"
                    expect(page).to have_text "Cannot be blank"                    
                end
            end
        end
        context "if the current password was incorrect" do
            it "must style the current password input field red" do
                @users.each do |user|
                    sign_in user
                    visit change_password_path
                    fill_in "user[password]", with: "password1234"
                    fill_in "user[password_confirmation]", with: "password1234"
                    fill_in "user[current_password]", with: "wrongPassword123"
                    click_on "Save"
                    expect(page).to have_css "input.form-control.is-invalid[name='user[current_password]']"
                end
            end
            it "must reenable the 'Save' button" do
                @users.each do |user|
                    sign_in user
                    visit change_password_path
                    fill_in "user[password]", with: "password1234"
                    fill_in "user[password_confirmation]", with: "password1234"
                    fill_in "user[current_password]", with: "wrongPassword123"
                    click_on "Save"
                    expect(page).to have_css "input[data-test-id='submit_change_password_button'][value='Save']:enabled"
                end
            end
            it "must show a message saying the password was incorrect" do
                @users.each do |user|
                    sign_in user
                    visit change_password_path
                    fill_in "user[password]", with: "password1234"
                    fill_in "user[password_confirmation]", with: "password1234"
                    fill_in "user[current_password]", with: "wrongPassword123"
                    click_on "Save"
                    expect(page).to have_css "div.invalid-feedback"
                    expect(page).to have_text "Incorrect password"
                end
            end
        end
        context "if the new password was less than #{Rails.configuration.MINIMUM_PASSWORD_LENGTH}" do
            it "must style the password input field red" do
                @users.each do |user|
                    sign_in user
                    visit change_password_path
                    fill_in "user[password]", with: "1234567"
                    fill_in "user[password_confirmation]", with: "1234567"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "input.form-control.is-invalid[name='user[password]']"
                end
            end
            it "must reenable the 'Save' button" do
                @users.each do |user|
                    sign_in user
                    visit change_password_path
                    fill_in "user[password]", with: "1234567"
                    fill_in "user[password_confirmation]", with: "1234567"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "input[data-test-id='submit_change_password_button'][value='Save']:enabled"
                end
            end
            it "must show a message saying the password is not valid" do
                @users.each do |user|
                    sign_in user
                    visit change_password_path
                    fill_in "user[password]", with: "1234567"
                    fill_in "user[password_confirmation]", with: "1234567"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "div.invalid-feedback"
                    expect(page).to have_text "Must have 8 or more characters"                    
                end
            end
        end
        context "if the password confirmation did not match the new password" do
            it "must style the password confirmation input field red" do
                @users.each do |user|
                    sign_in user
                    visit change_password_path
                    fill_in "user[password]", with: "password123"
                    fill_in "user[password_confirmation]", with: "differentPassword123"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "input.form-control.is-invalid[name='user[password_confirmation]']"
                end
            end
            it "must reenable the 'Save' button" do
                @users.each do |user|
                    sign_in user
                    visit change_password_path
                    fill_in "user[password]", with: "password123"
                    fill_in "user[password_confirmation]", with: "differentPassword123"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "input[data-test-id='submit_change_password_button'][value='Save']:enabled"
                end
            end
            it "must show a message saying there was a mismatch" do
                @users.each do |user|
                    sign_in user
                    visit change_password_path
                    fill_in "user[password]", with: "password123"
                    fill_in "user[password_confirmation]", with: "differentPassword123"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "div.invalid-feedback"
                    expect(page).to have_text "Does not match new password"                    
                end
            end
        end
        context "if the update succeeded" do
            it "must take the user to the account section of the settings page" do
                @users.each_with_index do |user, i|
                    sign_in user
                    visit change_password_path
                    fill_in "user[password]", with: "password123"
                    fill_in "user[password_confirmation]", with: "password123"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    sleep 0.05 # The test fails unless given time for the value of current_path to update
                    expect(current_path).to eq settings_path
                end
            end
            it "must show a flash message saying the password was changed" do
                @users.each_with_index do |user, i|
                    sign_in user
                    visit change_password_path
                    fill_in "user[password]", with: "password123"
                    fill_in "user[password_confirmation]", with: "password123"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_text "Account details updated."
                end
            end
        end
    end
end