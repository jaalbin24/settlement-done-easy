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
            expect(page).to have_css "li.nav-item[data-test-id='settings_nav_bar_account_button']"
        end
        it "must show the user's email" do
            expect(page).to have_text @user.email
        end
        it "must show the user's phone number" do
            expect(page).to have_text ActiveSupport::NumberHelper.number_to_phone(@user.phone_number, area_code: true)
        end
        context "after the user clicks the 'Change email' button" do
            before do
                @user = create(:law_firm)
                sign_in @user
                visit settings_path(section: "account")
                click_on "Change email"
            end
            it "must take the user to the edit email page" do
                expect(current_path).to eq change_email_path
            end
        end
        context "after the user clicks the 'Change password' button" do
            before do
                @user = create(:law_firm)
                sign_in @user
                visit settings_path(section: "account")
                click_on "Change password"
            end
            it "must take the user to the edit password page" do
                pending "Implementation"
                fail
            end
        end
        context "after the user clicks the 'Change phone number' button" do
            before do
                @user = create(:law_firm)
                sign_in @user
                visit settings_path(section: "account")
                click_on "Change phone number"
            end
            it "must take the user to the edit phone number page" do
                expect(current_path).to eq change_phone_number_path
            end
        end
    end
end