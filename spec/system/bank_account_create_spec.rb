require "rails_helper"

RSpec.describe "A law firm" do
    include_context "devise"
    before(:each) do
        @user = create(:law_firm)
    end
    it "creates a bank account" do
        sign_in @user
        visit root_path
        click_on "Add account"
        within_frame do
            click_on "Agree", wait: 4
            click_on "Test Institution", wait: 4
            find('div[data-testid="success"]').click
            click_on "Link account", wait: 4
            click_on "Done", wait: 4
            click_button "Accept", wait: 4
        end
        expect(page).to have_text "Bank Account Mandate"
        sleep(1) # Give modal time to load
        click_button "mandate-accept-button"
        sleep(1) # Give Stripe CLI time to trigger bank account creation.
        visit current_path
        expect(page).to have_text "STRIPE TEST BANK"
    end
end