require "rails_helper"

RSpec.describe "The user signs up", type: :system do
    context "from the home page" do
        it "as a law firm" do
            expect(User.all.size).to eq(0)
            name = random_law_firm_name
            visit root_path
            click_on "Sign up"
            click_on "Law Firm"
            fill_in "user_business_name", with: name
            fill_in "user_email", with: "#{name.gsub(/[\W]/, "")}@example.com"
            fill_in "Password", with: "password123"
            fill_in "Confirm password", with: "password123"
            click_button "Sign up"
            expect(page).to have_text "You have signed up successfully."
        end
        it "as an insurance company" do
            expect(User.all.size).to eq(0)
            name = random_insurance_company_name
            visit root_path
            click_on "Sign up"
            click_on "Insurance Company"
            fill_in "user_business_name", with: name
            fill_in "user_email", with: "#{name.gsub(/[\W]/, "")}@example.com"
            fill_in "Password", with: "password123"
            fill_in "Confirm password", with: "password123"
            click_button "Sign up"
            expect(page).to have_text "You have signed up successfully."
        end
    end
end