require "rails_helper"

RSpec.describe "The scratchpad" do
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
    context "when the owner is a member-type user" do
        context "with profile settings set to show the Last name to members of the same organization only" do
            before :context do
                attorney = create(:attorney) do |user|
                    user.settings.profile.show_last_name_to_members_only = true
                    user.settings.profile.save
                end
                extra_attorney = create(:attorney, organization: attorney.organization)
                adjuster = create(:adjuster) do |user|
                    user.settings.profile.show_last_name_to_members_only = true
                    user.settings.profile.save
                end
                extra_adjuster = create(:adjuster, organization: adjuster.organization)
                @owners = [attorney, adjuster]
                @extras = [extra_attorney, extra_adjuster]
            end
            after :context do
                @owners.each {|owner| owner.destroy} 
                @extras.each {|extra| extra.destroy}
            end
            context "and the user is a member of the same organization" do
                it "must have the owner's Last name" do
                    @owners.each do |owner|
                        @extras.each do |extra|
                            expect(extra.organization.full_name).to eq owner.organization.full_name
                            expect(extra.organization.id).to eq owner.organization.id
                            expect(extra.organization.id.nil?).to eq false
                            sign_in extra
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text owner.profile.full_name, wait: 15
                        end
                    end
                end
            end
            context "and the user is not a member of the same organization" do
                it "must not have the owner's Last name" do
                    @owners.each do |owner|
                        @users.each do |user|
                            sign_in user
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Last name"
                            expect(page).to_not have_text owner.profile.full_name
                        end
                    end
                end
            end
        end
        context "with profile settings set to show the Last name to the public" do
            before :context do
                attorney = build(:attorney) do |user|
                    user.settings = build(:user_settings)
                    user.settings.profile = build(:user_profile_settings, show_last_name_to_members_only: true)
                    user.save
                end
                extra_attorney = create(:attorney, organization: attorney.organization)
                adjuster = build(:adjuster) do |user|
                    user.settings = build(:user_settings)
                    user.settings.profile = build(:user_profile_settings, show_last_name_to_members_only: true)
                    user.save
                end
                extra_adjuster = create(:adjuster, organization: adjuster.organization)
                @owners = [attorney, adjuster]
                @extras = [extra_attorney, extra_adjuster]
            end
            after :context do
                @owners.each {|owner| owner.destroy} 
                @extras.each {|extra| extra.destroy}
            end
            it "must have the owner's Last name" do
                @owners.each do |owner|
                    @users.each do |user|
                        sign_in user
                        visit user_profile_show_path(owner.profile)
                        expect(page).to have_text owner.profile.full_name
                    end
                    @extras.each do |extra|
                        sign_in extra
                        visit user_profile_show_path(owner.profile)
                        expect(page).to have_text owner.profile.full_name
                    end
                end
            end
        end
        context "with profile settings set to show the last name to nobody" do
            context "and the user is a member of the same organization" do
                it "must not have the owner's Last name" do
                    @owners.each do |owner|
                        user = create(owner.role.to_sym, ApplicationHelper.organization_role_name(owner).to_sym => owner.organization)
                        sign_in user
                        visit user_profile_show_path(owner.profile)
                        expect(page).to_not have_text "Last name"
                        expect(page).to_not have_text owner.profile.full_name
                    end
                end
            end
            context "and the user is not a member of the same organization" do
                it "must not have the owner's Last name" do
                    @owners.each do |owner|
                        @users.each do |user|
                            sign_in user
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Last name"
                            expect(page).to_not have_text owner.profile.full_name
                        end
                    end
                end
            end
        end
    end
end