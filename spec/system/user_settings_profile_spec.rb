require "rails_helper"
# The 'owner' refers to the user that the profile represents. If a profile page for John Smith is being accessed, John Smith is the owner.
RSpec.describe "The profile section of the user settings page", type: :system do
    include_context "devise"
    before :context do
        @law_firm = create(:law_firm)
        @insurance_company = create(:insurance_company)
        @attorney = @law_firm.members.first
        @adjuster = @insurance_company.members.first
        @organizations = [@law_firm, @insurance_company]
        @members = [@attorney, @adjuster]
        @users = [@law_firm, @insurance_company, @attorney, @adjuster]
    end
    after :context do
        @users.each do |user|
            user.destroy
        end
    end

    before :each do
        @users.each do |user|
            sign_out
        end
    end

    it "must have a link to the user's profile show page" do
        @users.each do |user|
            sign_in user
            visit profile_settings_path
            expect(page).to have_css "a.btn.btn-outline-primary[href='#{user_profile_show_path(user.profile)}']"
            expect(page).to have_link "Go to profile"
            click_on "Go to profile"
            sleep 0.05
            expect(current_path).to eq user_profile_show_path(user.profile)
        end
    end
    describe "in the privacy form" do
        context "when the user is an organization" do
            it "must have switch boxes for the organization-specific profile attributes" do
                @organizations.each do |user|
                    sign_in user
                    visit profile_settings_path
                    expect(page).to have_css "input[name='user_profile_settings[show_tax_id_to_public]']"
                    expect(page).to have_css "input[name='user_profile_settings[show_tax_id_to_members_only]']"
                    
                    expect(page).to have_css "input[name='user_profile_settings[show_legal_name_to_public]']"
                    expect(page).to have_css "input[name='user_profile_settings[show_legal_name_to_members_only]']"

                    expect(page).to have_css "input[name='user_profile_settings[show_mcc_to_public]']"
                    expect(page).to have_css "input[name='user_profile_settings[show_mcc_to_members_only]']"

                    expect(page).to have_css "input[name='user_profile_settings[show_product_description_to_public]']"
                    expect(page).to have_css "input[name='user_profile_settings[show_product_description_to_members_only]']"
                end
            end
            it "must not have switch boxes for the member-specific profile attributes" do
                @organizations.each do |user|
                    sign_in user
                    visit profile_settings_path
                    expect(page).to_not have_css "input[name='user_profile_settings[show_last_name_to_public]']"
                    expect(page).to_not have_css "input[name='user_profile_settings[show_last_name_to_members_only]']"
                    
                    expect(page).to_not have_css "input[name='user_profile_settings[show_date_of_birth_to_public]']"
                    expect(page).to_not have_css "input[name='user_profile_settings[show_date_of_birth_to_members_only]']"

                    expect(page).to_not have_css "input[name='user_profile_settings[show_relationship_to_business_to_public]']"
                    expect(page).to_not have_css "input[name='user_profile_settings[show_relationship_to_business_to_members_only]']"

                    expect(page).to_not have_css "input[name='user_profile_settings[show_last_4_of_ssn_to_public]']"
                    expect(page).to_not have_css "input[name='user_profile_settings[show_last_4_of_ssn_to_members_only]']"

                    expect(page).to_not have_css "input[name='user_profile_settings[show_percent_ownership_to_public]']"
                    expect(page).to_not have_css "input[name='user_profile_settings[show_percent_ownership_to_members_only]']"
                end
            end
            # 'universal' profile attributes are the fields that organization-type users
            # and member-type users both have such as profile.email and profile.phone_number
            it "must have switch boxes for the universal profile attributes" do
                @organizations.each do |user|
                    sign_in user
                    visit profile_settings_path
                    expect(page).to have_css "input[name='user_profile_settings[show_email_to_public]']"
                    expect(page).to have_css "input[name='user_profile_settings[show_email_to_members_only]']"

                    expect(page).to have_css "input[name='user_profile_settings[show_phone_number_to_public]']"
                    expect(page).to have_css "input[name='user_profile_settings[show_phone_number_to_members_only]']"

                    expect(page).to have_css "input[name='user_profile_settings[show_address_to_public]']"
                    expect(page).to have_css "input[name='user_profile_settings[show_address_to_members_only]']"
                end
            end
        end
        context "when the user is a member" do
            it "must not have switch boxes for the organization-specific profile attributes" do
                @members.each do |user|
                    sign_in user
                    visit profile_settings_path
                    expect(page).to_not have_css "input[name='user_profile_settings[show_tax_id_to_public]']"
                    expect(page).to_not have_css "input[name='user_profile_settings[show_tax_id_to_members_only]']"
                    
                    expect(page).to_not have_css "input[name='user_profile_settings[show_legal_name_to_public]']"
                    expect(page).to_not have_css "input[name='user_profile_settings[show_legal_name_to_members_only]']"

                    expect(page).to_not have_css "input[name='user_profile_settings[show_mcc_to_public]']"
                    expect(page).to_not have_css "input[name='user_profile_settings[show_mcc_to_members_only]']"

                    expect(page).to_not have_css "input[name='user_profile_settings[show_product_description_to_public]']"
                    expect(page).to_not have_css "input[name='user_profile_settings[show_product_description_to_members_only]']"
                end
            end
            it "must have switch boxes for the member-specific profile attributes" do
                @members.each do |user|
                    sign_in user
                    visit profile_settings_path
                    expect(page).to have_css "input[name='user_profile_settings[show_last_name_to_public]']"
                    expect(page).to have_css "input[name='user_profile_settings[show_last_name_to_members_only]']"
                    
                    expect(page).to have_css "input[name='user_profile_settings[show_date_of_birth_to_public]']"
                    expect(page).to have_css "input[name='user_profile_settings[show_date_of_birth_to_members_only]']"

                    expect(page).to have_css "input[name='user_profile_settings[show_relationship_to_business_to_public]']"
                    expect(page).to have_css "input[name='user_profile_settings[show_relationship_to_business_to_members_only]']"

                    expect(page).to have_css "input[disabled][name='user_profile_settings[show_last_4_of_ssn_to_public]']"
                    expect(page).to have_css "input[disabled][name='user_profile_settings[show_last_4_of_ssn_to_members_only]']"

                    expect(page).to have_css "input[name='user_profile_settings[show_percent_ownership_to_public]']"
                    expect(page).to have_css "input[name='user_profile_settings[show_percent_ownership_to_members_only]']"
                end
            end
            # 'universal' profile attributes are the fields that organization-type users
            # and member-type users both have such as profile.email and profile.phone_number
            it "must have switch boxes for the universal profile attributes" do
                @members.each do |user|
                    sign_in user
                    visit profile_settings_path
                    expect(page).to have_css "input[name='user_profile_settings[show_email_to_public]']"
                    expect(page).to have_css "input[name='user_profile_settings[show_email_to_members_only]']"

                    expect(page).to have_css "input[name='user_profile_settings[show_phone_number_to_public]']"
                    expect(page).to have_css "input[name='user_profile_settings[show_phone_number_to_members_only]']"

                    expect(page).to have_css "input[name='user_profile_settings[show_address_to_public]']"
                    expect(page).to have_css "input[name='user_profile_settings[show_address_to_members_only]']"
                end
            end
        end
    end
end