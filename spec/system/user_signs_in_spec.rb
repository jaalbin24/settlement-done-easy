RSpec.describe "User signs in" do
    scenario "and they start at the home page" do
        visit root_path
        click_on "Sign in"
        fill_in "Email", with: "insurance_company0@example.com"
        fill_in "Password", with: "password123"
        click_on "Sign in"
        expect(page).to have_text "State Farm"
    end

    scenario "and they start somewhere else" do
        visit root_path
        click_on "Sign in"
        fill_in "Email", with: "insurance_company0@example.com"
        fill_in "Password", with: "password123"
        click_on "Sign in"
        expect(page).to have_text "State Farm"
    end
end