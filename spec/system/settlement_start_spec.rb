require "rails_helper"

RSpec.describe "A member starting a settlement", type: :system do
    include_context "devise"
    context "from their dashboard" do
        context "when their organization's account is not activated" do
            before(:each) do
                @members = [create(:attorney, :with_unactivated_organization_due_to_lack_of_bank_account), create(:adjuster, :with_unactivated_organization_due_to_lack_of_bank_account)]
            end
            
            it "will be sent to their dashboard and see an error message" do
                @members.each do |u|
                    expect(u.organization.activated?).to be_falsey
                    sign_in u
                    visit root_path
                    click_on "New settlement"
                    expect(page).to have_text("#{u.role.titleize} Dashboard")
                    error_message = "You cannot start a settlement until #{u.organization.full_name}'s account is activated."
                    expect(page).to have_text(error_message)
                end
            end

            it "will not change the state of the database" do
                pending "Implementation"
                fail
            end
        end
        context "when their organization's account is activated" do
            before(:each) do
                @members = [create(:attorney), create(:adjuster)]
            end
            it "will be sent to the 'Start a New Settlement' page" do
                @members.each do |u|
                    expect(u.organization.activated?).to be_truthy
                    sign_in u
                    visit root_path
                    click_on "New settlement"
                    expect(page).to have_text("Start a New Settlement")
                end
            end
        end
        
    end

    context "from the 'Start a New Settlement' page" do
        context "when their organization's account is not activated" do
            before(:each) do
                @members = [create(:attorney, :with_unactivated_organization_due_to_lack_of_bank_account), create(:adjuster, :with_unactivated_organization_due_to_lack_of_bank_account)]
            end
            it "will be sent to their dashboard and see an error message" do
                @members.each do |u|
                    expect(u.organization.activated?).to be_falsey
                    sign_in u
                    visit settlement_new_path
                    expect(page).to have_text("#{u.role.titleize} Dashboard")
                    error_message = "You cannot start a settlement until #{u.organization.full_name}'s account is activated."
                    expect(page).to have_text(error_message)
                end
            end
            it "will not change the state of the database" do
                pending "Implementation"
                fail
            end
        end
        context "when their organization's account is activated" do
            before(:each) do
                @members = [create(:attorney), create(:adjuster)]
            end
            it "will be sent to the new settlement's show page and see a confirmation message" do
                @members.each do |u|
                    expect(u.organization.activated?).to be_truthy
                    partner = random_attorney if u.isInsuranceAgent?
                    partner = random_adjuster if u.isAttorney?
                    sign_in u
                    visit settlement_new_path
                    fill_in "settlement[claimant_name]",        with: "Cleo Claimant"
                    fill_in "settlement[policy_holder_name]",       with: "Patty Policyholder"
                    fill_in "settlement[incident_date]",        with: rand(10..1000).days.ago
                    fill_in "settlement[incident_location]",    with: "Earth"
                    fill_in "settlement[amount]",               with: rand(Rails.configuration.PAYMENT_MINIMUM_IN_DOLLARS..Rails.configuration.PAYMENT_MAXIMUM_IN_DOLLARS)
                    fill_in "settlement[claim_number]",         with: "C-xxxTESTxxx"
                    select "#{partner.full_name} (#{partner.organization.full_name})", from: "partner_id"
                    click_on "Start!"
                    expect(page).to have_text("The following requirements must be met to complete this settlement.")
                    expect(page).to have_text("Started a new settlement with #{partner.full_name}! Click here to view it.")
                end
            end
        end
    end
end