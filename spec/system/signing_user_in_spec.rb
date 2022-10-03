require "rails_helper"

RSpec.describe "The user signs in", type: :system do
    it "from the home page" do
        user = create(:law_firm)
        visit root_path
        click_on "Sign in"
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"

        expect(page).to have_text user.full_name
    end
end