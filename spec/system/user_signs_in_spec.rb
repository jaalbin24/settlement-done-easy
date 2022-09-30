RSpec.describe "User signs in" do
    fixtures :users
    scenario "from the home page" do
        visit root_path
        click_on "Sign in"
        fill_in "Email", with: "state_farm.test@example.com"
        fill_in "Password", with: "password123"
        click_button "Sign in"
        expect(page).to have_text "State Farm"
    end
end