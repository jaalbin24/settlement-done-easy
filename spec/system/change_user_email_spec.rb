require "rails_helper"

RSpec.describe "The change email page", type: :system do
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
    it "must have a field to enter the new email" do
        @users.each do |user|
            sign_in user
            visit change_email_path
            expect(page).to have_css "input.form-control[name='user[email]']"
        end
    end
    it "must have a field to enter the user's current password" do
        @users.each do |user|
            sign_in user
            visit change_email_path
            expect(page).to have_css "input.form-control[name='user[current_password]']"
        end
    end
    it "must have a button labeled 'Save'" do
        @users.each do |user|
            sign_in user
            visit change_email_path
            expect(page).to have_css "input[data-test-id='submit_change_email_button'][value='Save']"
        end
    end
    context "after the 'Save' button is pressed" do
        context "if the current password was incorrect" do
            it "must style the current password input field red" do
                @users.each do |user|
                    sign_in user
                    visit change_email_path
                    fill_in "user[email]", with: "new.email@example.com"
                    fill_in "user[current_password]", with: "wrongPassword123"
                    click_on "Save"
                    expect(page).to have_css "input.form-control.is-invalid[name='user[current_password]']"
                end
            end
            it "must reenable the 'Save' button" do
                @users.each do |user|
                    sign_in user
                    visit change_email_path
                    fill_in "user[email]", with: "new.email@example.com"
                    fill_in "user[current_password]", with: "wrongPassword123"
                    click_on "Save"
                    expect(page).to have_css "input[data-test-id='submit_change_email_button'][value='Save']:enabled"
                end
            end
            it "must show a message saying the password was incorrect" do
                @users.each do |user|
                    sign_in user
                    visit change_email_path
                    fill_in "user[email]", with: "new.email@example.com"
                    fill_in "user[current_password]", with: "wrongPassword123"
                    click_on "Save"
                    expect(page).to have_css "div.invalid-feedback"
                    expect(page).to have_text "Incorrect password"
                end
            end
        end
        context "if the new email was incorrectly formatted" do
            it "must style the email input field red" do
                @users.each do |user|
                    sign_in user
                    visit change_email_path
                    fill_in "user[email]", with: "incorrect@example"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "input.form-control.is-invalid[name='user[email]']"
                end
            end
            it "must reenable the 'Save' button" do
                @users.each do |user|
                    sign_in user
                    visit change_email_path
                    fill_in "user[email]", with: "incorrect@example"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "input[data-test-id='submit_change_email_button'][value='Save']:enabled"
                end
            end
            it "must show a message saying the email is not valid" do
                @users.each do |user|
                    sign_in user
                    visit change_email_path
                    fill_in "user[email]", with: "incorrect@example"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "div.invalid-feedback"
                    expect(page).to have_text "Please enter a valid email"                    
                end
            end
        end
        context "if the new email is already taken" do
            it "must style the email input field red" do
                @users.each_with_index do |user, i|
                    sign_in user
                    visit change_email_path
                    fill_in "user[email]", with: @users.to_a[i+1].nil? ? @users.to_a[0].email : @users.to_a[i+1].email
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "div.invalid-feedback"
                    expect(page).to have_text "This email is already taken"                    
                end
            end
            it "must reenable the 'Save' button" do
                @users.each_with_index do |user, i|
                    sign_in user
                    visit change_email_path
                    fill_in "user[email]", with: @users.to_a[i+1].nil? ? @users.to_a[0].email : @users.to_a[i+1].email
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "input[data-test-id='submit_change_email_button'][value='Save']:enabled"
                end
            end
            it "must show a message saying the email is already taken" do
                @users.each_with_index do |user, i|
                    sign_in user
                    visit change_email_path
                    fill_in "user[email]", with: @users.to_a[i+1].nil? ? @users.to_a[0].email : @users.to_a[i+1].email
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_css "div.invalid-feedback"
                    expect(page).to have_text "This email is already taken"
                end
            end
        end
        context "if the update succeeded" do
            it "must take the user to the account section of the settings page" do
                @users.each_with_index do |user, i|
                    sign_in user
                    visit change_email_path
                    fill_in "user[email]", with: "new.email#{i}@example.com"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    sleep 0.05 # The test fails unless given time for the value of current_path to update
                    expect(current_path).to eq settings_path
                end
            end
            it "must show a flash message saying the email was changed" do
                @users.each_with_index do |user, i|
                    sign_in user
                    visit change_email_path
                    fill_in "user[email]", with: "new.email#{i}.#{i+1}@example.com"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Save"
                    expect(page).to have_text "Your email was changed to new.email#{i}.#{i+1}@example.com."
                end
            end
        end
    end
end