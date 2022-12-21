require "rails_helper"

RSpec.describe "The account section of the user settings page" do
    include_context "devise"
    context do
        before do
            @user = create(:law_firm)
            sign_in @user
            visit settings_path(section: "account")
        end
        it "must have a nav-bar button labeled 'Account'" do
            expect(page).to have_button "settings-nav-bar-account-button"
        end
        it "must have a Details section" do
            expect(page).to have_text "Account Details"
        end
        it "must have a Requirements section" do
            expect(page).to have_text "Requirements"
        end
    end

    describe "in the Details section" do
        before do
            @user = create(:law_firm)
            sign_in @user
            visit settings_path
        end
        it "must have a field to edit the user's email" do
            expect(page).to have_css "input[name='user[email]']"
        end
        it "must have a read-only field with astericks representing the user's password" do
            expect(page).to have_css "input[id='password-placeholder'][readonly='readonly']"
        end
        it "must have a button labeled 'Change password' that opens the change password modal" do
            expect(page).to_not have_text "Change Your Password"
            expect(page).to have_button "Change password"
            click_on "Change password"
            expect(page).to have_css "div.modal.fade[name='change-password-modal']"
        end
        it "must have a field to edit the user's phone number" do
            expect(page).to have_css "input[name='user[phone_number]']"
        end
        it "must have a button labeled 'Update'" do
            expect(page).to have_css "button[name='open-password-confirmation-button']", text: "Update"
        end
        context "after clicking the 'Update' button" do
            before do
                @user = create(:law_firm)
                sign_in @user
                visit settings_path
                click_on "Update"
            end
            it "must open the password confirmation modal" do
                expect(page).to have_css "div.modal.fade[name='password-confirmation-modal']"
            end
            context "and submitting the password confirmation form" do
                context "if the email was changed" do
                    before do
                        @user = create(:law_firm)
                        sign_in @user
                        visit settings_path
                        fill_in "user[email]", with: "new.email@example.com"
                        click_on "Update"
                        fill_in "user[current_password]", with: "password123"
                        click_on "submit-edit-user-button"
                    end
                    it "must show the new email in the email input field" do
                        expect(page).to have_css "input[name='user[email]'][value='new.email@example.com']"
                    end
                end
                context "if the email was not changed" do
                    before do
                        @user = create(:law_firm)
                        sign_in @user
                        visit settings_path
                        click_on "Update"
                        fill_in "user[current_password]", with: "password123"
                        click_on "submit-edit-user-button"
                    end
                    it "must show the original email in the email input field" do
                        expect(page).to have_css "input[name='user[email]'][value='#{@user.email}']"
                    end
                end
                context "if the phone number was changed" do
                    before do
                        @user = create(:law_firm)
                        sign_in @user
                        visit settings_path
                        fill_in "user[phone_number]", with: "9184944752"
                        click_on "Update"
                        fill_in "user[current_password]", with: "password123"
                        click_on "submit-edit-user-button"
                    end
                    it "must show the new phone number in the phone number input field" do
                        
                    end
                end
                context "if the phone number was not changed" do
                    before do
                        @user = create(:law_firm)
                        sign_in @user
                        visit settings_path
                        click_on "Update"
                        fill_in "user[current_password]", with: "password123"
                        click_on "submit-edit-user-button"
                    end
                    it "must show the original phone number in the phone number input field" do
                        expect(page).to have_css "input[name='user[phone_number]'][value='#{ActiveSupport::NumberHelper.number_to_phone(@user.phone_number, area_code: true)}']"
                    end
                end
            end
        end
        context "when the user's email is verified" do
            it "must have a stamp saying the user's email is verified" do
                pending "Implementation"
                fail
            end
        end
        context "when the user's email is not verified" do
            it "must have a stamp saying the user's email is not verified" do
                pending "Implementation"
                fail
            end
        end
        context "when MFA is enabled" do
            it "must have a link to disable MFA" do
                pending "Implementation"
                fail
            end
        end
        context "when MFA is disabled" do
            it "must have a button that opens the MFA activation modal" do
                pending "Implementation"
                fail
            end
        end
    end

    describe "in the change password modal" do
        it "must have a field to enter the current password" do
            pending "Implementation"
            fail
        end
        it "must have a field to enter the new password" do
            pending "Implementation"
            fail
        end
        it "must have a field to reenter the new password" do
            pending "Implementation"
            fail
        end
        it "must have a submit button labeled 'Submit' that submits the form" do
            pending "Implementation"
            fail
        end
        context "after the 'Submit' button has been pressed" do
            context "if the password was successfully changed" do
                before do
                    @user = create(:law_firm)
                    sign_in @user
                    visit settings_path
                    click_on "Change password"
                    fill_in "user[current_password]", with: "password123"
                    fill_in "user[password]", with: "newPassword123"
                    fill_in "user[password_confirmation]", with: "newPassword123"                    
                    click_on "Submit"
                end
                it "must have a message saying the password was changed" do
                    pending "Implementation"
                    fail
                end
                it "must have a button labeled 'Close' that closes the modal" do
                    pending "Implementation"
                    fail
                end
                it "must not have a button labeled 'Change password'" do
                    pending "Implementation"
                    fail
                end
            end
            context "if the current password was not correct" do
                before do
                    @user = create(:law_firm)
                    sign_in @user
                    visit settings_path
                    click_on "Change password"
                    fill_in "user[current_password]", with: "incorrectPassword123"
                    fill_in "user[password]", with: "newPassword123"
                    fill_in "user[password_confirmation]", with: "newPassword123"                    
                    click_on "Submit"
                end
                it "must reenable the 'Update' button" do
                    expect(page).to have_css "button[name='submit-change-password-button']:enabled"
                end
                it "must change the styling of the input field to invalid" do
                    expect(page).to have_css "input.is-invalid[name='user[current_password]']"
                end
                it "must have a message saying the password was incorrect" do
                    expect(page).to have_css "div.invalid-feedback[name='incorrect-password-error-message']"
                    expect(page).to have_text "Incorrect password"
                end
            end
            context "if the new password and confirmation password did not match" do
                before do
                    @user = create(:law_firm)
                    sign_in @user
                    visit settings_path
                    click_on "Change password"
                    fill_in "user[current_password]", with: "password123"
                    fill_in "user[password]", with: "newPasswordABC"
                    fill_in "user[password_confirmation]", with: "newPasswordXYZ"                     
                    click_on "Submit"
                end
                it "must reenable the 'Submit' button" do
                    expect(page).to have_css "button[name='submit-change-password-button']:enabled"
                end
                it "must change the styling of the password confirmation input field to invalid" do
                    expect(page).to have_css "input.is-invalid[name='user[password_confirmation]']"
                end
                it "must have a message saying the passwords did not match" do
                    expect(page).to have_css "div.invalid-feedback[name='mismatch-password-error-message']"
                    expect(page).to have_text "Does not match the new password"
                end
                it "must not have a message saying the password must be less than #{Rails.configuration.MINIMUM_PASSWORD_LENGTH} characters" do
                    expect(page).to_not have_css "div.invalid-feedback[name='short-password-error-message']"
                    expect(page).to_not have_text "Must have 8 or more characters"
                end
                it "must not have a message saying the password cannot be blank" do
                    expect(page).to_not have_css "div.invalid-feedback[name='blank-password-error-message']"
                    expect(page).to_not have_text "Cannot be blank"
                end
                it "must not have a message saying the password was incorrect" do
                    expect(page).to_not have_css "div.invalid-feedback[name='incorrect-password-error-message']"
                    expect(page).to_not have_text "Incorrect password"
                end
            end
            context "if the new password field was blank" do
                before do
                    @user = create(:law_firm)
                    sign_in @user
                    visit settings_path
                    click_on "Change password"
                    fill_in "user[current_password]", with: "password123"
                    click_on "Submit"
                end
                it "must reenable the 'Submit' button" do
                    expect(page).to have_css "button[name='submit-change-password-button']:enabled"
                end
                it "must change the styling of the input field to invalid" do
                    expect(page).to have_css "input.is-invalid[name='user[password]']"
                end
                it "must have a message saying the field cannot be blank" do
                    expect(page).to have_css "div.invalid-feedback[name='blank-password-error-message']"
                    expect(page).to have_text "Cannot be blank"
                end
                it "must not have a message saying the password must be less than #{Rails.configuration.MINIMUM_PASSWORD_LENGTH} characters" do
                    expect(page).to_not have_css "div.invalid-feedback[name='short-password-error-message']"
                    expect(page).to_not have_text "Must have 8 or more characters"
                end
                it "must not have a message saying the password was incorrect" do
                    expect(page).to_not have_css "div.invalid-feedback[name='incorrect-password-error-message']"
                    expect(page).to_not have_text "Incorrect password"
                end
                it "must not have a message saying the passwords did not match" do
                    expect(page).to_not have_css "div.invalid-feedback[name='mismatch-password-error-message']"
                    expect(page).to_not have_text "Does not match the new password"
                end
            end
            context "if the new password was less than #{Rails.configuration.MINIMUM_PASSWORD_LENGTH} characters" do
                before do
                    @user = create(:law_firm)
                    sign_in @user
                    visit settings_path
                    click_on "Change password"
                    fill_in "user[current_password]", with: "password123"
                    fill_in "user[password]", with: "n3wPass"
                    fill_in "user[password_confirmation]", with: "n3wPass"
                    click_on "Submit"
                end
                it "must reenable the 'Submit' button" do
                    expect(page).to have_css "button[name='submit-change-password-button']:enabled"
                end
                it "must change the styling of the input field to invalid" do
                    expect(page).to have_css "input.is-invalid[name='user[password]']"
                end
                it "must have a message saying the password must be less than #{Rails.configuration.MINIMUM_PASSWORD_LENGTH} characters" do
                    expect(page).to have_css "div.invalid-feedback[name='short-password-error-message']"
                    expect(page).to have_text "Must have 8 or more characters"
                end
                it "must not have a message saying the field cannot be blank" do
                    expect(page).to_not have_css "div.invalid-feedback[name='blank-password-error-message']"
                    expect(page).to_not have_text "Cannot be blank"
                end
                it "must not have a message saying the password was incorrect" do
                    expect(page).to_not have_css "div.invalid-feedback[name='incorrect-password-error-message']"
                    expect(page).to_not have_text "Incorrect password"
                end
            end
        end
    end

    describe "in the MFA activation modal" do
        it "must have a tab for authentication via SMS" do
            pending "Implementation"
            fail
        end
        it "must have a tab for authentication via an authenticator app" do
            pending "Implementation"
            fail
        end
        describe "in the SMS tab" do
            it "must have directions for the user" do
                pending "Implementation"
                fail
            end
            it "must have a field to enter the user's phone number" do
                pending "Implementation"
                fail
            end
            it "must have a button labeled 'Send code' that submits the phone number form" do
                pending "Implementation"
                fail
            end
            context "after the phone number form is submitted" do
                it "must have directions for the user" do
                    pending "Implementation"
                    fail
                end
                it "must have a field to enter the SMS verification code" do
                    pending "Implementation"
                    fail
                end
                it "must have a button labeled 'Verify' that submits the SMS code form" do
                    pending "Implementation"
                    fail
                end
                it "must have a button labeled 'Resend code' that resends the SMS verification code" do
                    pending "Implementation"
                    fail
                end
                it "must disable the 'Resend code' button for 10 seconds then enable it" do
                    pending "Implementation"
                    fail
                end
                it "must show a 10 second timer on the 'Resend code' button" do
                    pending "Implementation"
                    fail
                end
                context "if phone number verification succeeds" do
                    it "must have directions for the user" do
                        pending "Implementation"
                        fail
                    end
                    it "must have a success message" do
                        pending "Implementation"
                        fail
                    end
                    it "must have a button labeled 'Close'" do
                        pending "Implementation"
                        fail
                    end
                end
                context "if phone number verification fails" do
                    it "must have directions for the user" do
                        pending "Implementation"
                        fail
                    end
                    it "must have a failure message" do
                        pending "Implementation"
                        fail
                    end
                end
                context "after the 'Resend code' button is pressed" do
                    context "and the code is successfully sent" do
                        it "must have a message saying the code was resent" do
                            pending "Implementation"
                            fail
                        end
                    end
                    context "and the verification code fails to send" do
                        it "must have a message saying the code failed to send" do
                            pending "Implementation"
                            fail
                        end
                    end
                end
            end
        end
    end
    
    # This modal is just a way to gather the user's password before updating their account.
    describe "in the password confirmation modal" do
        it "must have a field to enter the user's password" do
            pending "Implementation"
            fail
        end
        it "must have a button labeled 'Update' that submits the user edit form" do
            pending "Implementation"
            fail
        end
        it "must list the planned changes to the user's account" do

        end
        context "when the 'Update' button is clicked" do
            it "must disable the 'Update' button" do
                pending "Implementation"
                fail
            end
            context "if the email was changed" do
                before do
                    @user = create(:law_firm)
                    sign_in @user
                    visit settings_path
                    fill_in "Email", with: "xyz123@example.com"
                    click_on "Update"
                    fill_in "user_current_password", with: "password123"
                    click_on "submit-edit-user-button"
                end
                it "must show a visual indicator that the email is not verified" do
                    pending "Implementation"
                    fail
                end
            end
            context "if the update succeeds" do
                before do
                    @user = create(:law_firm)
                    sign_in @user
                    visit settings_path
                    fill_in "Email", with: "xyz123@example.com"
                    click_on "Update"
                    fill_in "user_current_password", with: "password123"
                    click_on "submit-edit-user-button"
                end
                it "must show a message saying the account was updated" do
                    expect(page).to have_text "Account details updated."
                end
                it "must reflect the new changes" do
                    expect(page).to have_field("user_email", with: "xyz123@example.com")
                end
            end
            context "if the password is incorrect" do
                before do
                    @user = create(:law_firm)
                    sign_in @user
                    visit settings_path
                    fill_in "Email", with: "xyz123@example.com"
                    click_on "Update"
                    fill_in "user_current_password", with: "invalid_password999"
                    click_on "submit-edit-user-button"
                end
                it "must change the styling of the input to invalid" do
                    expect(page).to have_css "input.is-invalid[name='user[current_password]']"
                end
                it "must reenable the 'Update' button" do
                    expect(page).to have_css "button[name='submit-edit-user-button']:enabled"
                end
                it "must show a red notice under the input saying 'Incorrect password'" do
                    expect(page).to have_css "div.invalid-feedback[name='incorrect-password-error-message']"
                end
            end
            context "if the update fails" do
                context "because the phone number is invalid" do
                    it "must show a message saying the phone number is invalid" do
                        pending "Implementation"
                        fail
                    end
                end
                context "because the email is invalid" do
                    it "must show a message saying the email is invalid" do
                        pending "Implementation"
                        fail
                    end
                end
                context "for an unhandled reason" do
                    it "must show a generic error message" do
                        pending "Implementation"
                        fail
                    end
                end
            end
            context "if nothing was changed" do
                it "must show a message saying nothing was changed" do
                    pending "Implementation"
                    fail
                end
            end
        end
    end
end