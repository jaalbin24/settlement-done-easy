require "rails_helper"

RSpec.describe "The change phone number page" do
    include_context "devise"
    before(:context) do
        @law_firm = create(:law_firm)
        @insurance_company = create(:insurance_company)
        @attorney = @law_firm.members.first
        @adjuster = @insurance_company.members.first
        @users = [@law_firm, @insurance_company, @attorney, @adjuster]
    end
    it "must have a field to enter the new phone number" do
        @users.each do |user|
            sign_in user
            visit change_phone_number_path
            expect(page).to have_css "input.form-control[name='user[phone_number]']"
        end
    end
    it "must have a field to enter the user's current password" do
        @users.each do |user|
            sign_in user
            visit change_phone_number_path
            expect(page).to have_css "input.form-control[name='user[current_password]']"
        end
    end
    it "must have a button labeled 'Save'" do
        @users.each do |user|
            sign_in user
            visit change_phone_number_path
            expect(page).to have_css "input[data-test-id='submit_change_phone_number_button'][value='Save']"
        end
    end
    context "after the 'Save' button is pressed" do
        context "if the current password was blank" do
            it "must style the current password input field red" do
                @users.each do |user|
                    sign_in user
                    visit change_phone_number_path
                    fill_in "user[phone_number]", with: "1234567890"
                    click_on "Save"
                    expect(page).to have_css "input.form-control.is-invalid[name='user[current_password]']"
                end
            end
            it "must reenable the 'Save' button" do
                @users.each do |user|
                    sign_in user
                    visit change_phone_number_path
                    fill_in "user[phone_number]", with: "1234567890"
                    click_on "Save"
                    expect(page).to have_css "input[data-test-id='submit_change_phone_number_button'][value='Save']:enabled"
                end
            end
            it "must show a message saying the password cannot be blank" do
                @users.each do |user|
                    sign_in user
                    visit change_phone_number_path
                    fill_in "user[phone_number]", with: "1234567890"
                    click_on "Save"
                    expect(page).to have_css "div.invalid-feedback"
                    expect(page).to have_text "Cannot be blank"
                end
            end
        end
        context "if the new phone number was blank" do
            it "must style the phone_number input field red" do
                @users.each do |user|
                    sign_in user
                    visit change_phone_number_path
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "input.form-control.is-invalid[name='user[phone_number]']"
                end
            end
            it "must reenable the 'Save' button" do
                @users.each do |user|
                    sign_in user
                    visit change_phone_number_path
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "input[data-test-id='submit_change_phone_number_button'][value='Save']:enabled"
                end
            end
            it "must show a message saying the phone number cannot be blank" do
                @users.each do |user|
                    sign_in user
                    visit change_phone_number_path
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
                    visit change_phone_number_path
                    fill_in "user[phone_number]", with: "1234567890"
                    fill_in "user[current_password]", with: "wrongPassword123"
                    click_on "Save"
                    expect(page).to have_css "input.form-control.is-invalid[name='user[current_password]']"
                end
            end
            it "must reenable the 'Save' button" do
                @users.each do |user|
                    sign_in user
                    visit change_phone_number_path
                    fill_in "user[phone_number]", with: "1234567890"
                    fill_in "user[current_password]", with: "wrongPassword123"
                    click_on "Save"
                    expect(page).to have_css "input[data-test-id='submit_change_phone_number_button'][value='Save']:enabled"
                end
            end
            it "must show a message saying the password was incorrect" do
                @users.each do |user|
                    sign_in user
                    visit change_phone_number_path
                    fill_in "user[phone_number]", with: "1234567890"
                    fill_in "user[current_password]", with: "wrongPassword123"
                    click_on "Save"
                    expect(page).to have_css "div.invalid-feedback"
                    expect(page).to have_text "Incorrect password"
                end
            end
        end
        context "if the new phone number was incorrectly formatted" do
            it "must style the phone_number input field red" do
                @users.each do |user|
                    sign_in user
                    visit change_phone_number_path
                    fill_in "user[phone_number]", with: "(1800)1234567"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "input.form-control.is-invalid[name='user[phone_number]']"
                end
            end
            it "must reenable the 'Save' button" do
                @users.each do |user|
                    sign_in user
                    visit change_phone_number_path
                    fill_in "user[phone_number]", with: "(1800)1234567"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "input[data-test-id='submit_change_phone_number_button'][value='Save']:enabled"
                end
            end
            it "must show a message saying the phone number is not valid" do
                @users.each do |user|
                    sign_in user
                    visit change_phone_number_path
                    fill_in "user[phone_number]", with: "(1800)1234567"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "div.invalid-feedback"
                    expect(page).to have_text "Please enter a valid phone number"                    
                end
            end
        end
        context "if the update succeeded" do
            it "must take the user to the account section of the settings page" do
                @users.each_with_index do |user, i|
                    sign_in user
                    visit change_phone_number_path
                    fill_in "user[phone_number]", with: "1234567890"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    sleep 0.05 # The test fails unless given time for the value of current_path to update
                    expect(current_path).to eq settings_path
                end
            end
            it "must show a flash message saying the phone number was changed" do
                @users.each_with_index do |user, i|
                    sign_in user
                    visit change_phone_number_path
                    fill_in "user[phone_number]", with: "1234567890"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_text "Account details updated."
                end
            end
            it "must show the new phone number on the account settings page" do
                @users.each_with_index do |user, i|
                    sign_in user
                    visit change_phone_number_path
                    fill_in "user[phone_number]", with: "1234567890"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_text "(123) 456-7890"
                end
            end
        end
    end
end