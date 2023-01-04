require "rails_helper"

RSpec.describe "The scratchpad" do
    include_context "devise"
    context "when the owner is an organization-type user" do
        context "and the visitor is a member belonging to that organization" do

        end
        context "with profile settings set to show the MCC to its members only" do
            context "and the user is a member belonging to that organization" do
    
    
    
            end
        end
    end
    context "when the owner is a member-type user" do
        context "and the visitor is the owner" do
            it "must have all attributes of the owner's profile" do
                pending "Implementation"
                fail
            end
        end
        context "and the visitor is the owner's organization" do
            it "must have all attributes of the owner's profile" do
                pending "Implementation"
                fail
            end
        end
        # Iterate through attributes
        context "and the visitor is a member belonging to that organization" do
            context "and the owner has profile settings set to show their email to the public" do
                it "must have the owner's email" do
                    pending "Implementation"
                    fail
                end
            end
            context "and the owner has profile settings set to show their email to members of the same organization only" do
                it "must have the owner's email" do
                    pending "Implementation"
                    fail
                end
            end
            context "and the owner has profile settings set to show their email to nobody" do
                it "must not have the owner's email" do
                    pending "Implementation"
                    fail
                end
            end
        end



        # Iterate through attributes
        context "and the visitor is a member of another organization" do
            before :context do
                @visitors = [create(:attorney), create(:adjuster)]
            end
            after :context do
                @visitors.each {|v| v.destroy}
            end
            context "and the owner has profile settings set to show their email to the public" do
                before do
                    attorney = create(:attorney)
                    attorney.settings = create(:user_settings, user: attorney)
                    attorney.settings.profile = create(:user_profile_settings, user_settings: attorney.settings, show_email_to_public: true)

                    adjuster = create(:adjuster)
                    adjuster.settings = create(:user_settings, user: adjuster)
                    adjuster.settings.profile = create(:user_profile_settings, user_settings: adjuster.settings, show_email_to_public: true)
                    @owners = [attorney, adjuster]
                end
                it "must have the owner's email" do
                    @owners.each do |owner|
                        @visitors.each do |member|
                            sign_in member
                            visit user_profile_show_path(owner.profile)
                            expect(page).to have_text "Email"
                            expect(page).to have_text owner.email                            
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their email to members of the same organization only" do
                before do
                    attorney = build(:attorney) do |user|
                        user.settings = build(:user_settings)
                        user.settings.profile = build(:user_profile_settings, show_email_to_members_only: true)
                        user.save
                    end
                    adjuster = build(:adjuster) do |user|
                        user.settings = build(:user_settings)
                        user.settings.profile = build(:user_profile_settings, show_email_to_members_only: true)
                        user.save
                    end
                    @owners = [attorney, adjuster]
                end
                it "must not have the owner's email" do
                    @owners.each do |owner|
                        @visitors.each do |member|
                            sign_in member
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Email"
                            expect(page).to_not have_text owner.email                            
                        end
                    end
                end
            end
            context "and the owner has profile settings set to show their email to nobody" do
                before do
                    attorney = build(:attorney) do |user|
                        user.settings = build(:user_settings)
                        user.settings.profile = build(:user_profile_settings, show_email_to_members_only: false, show_email_to_public: false)
                        user.save
                    end
                    adjuster = build(:adjuster) do |user|
                        user.settings = build(:user_settings)
                        user.settings.profile = build(:user_profile_settings, show_email_to_members_only: false, show_email_to_public: false)
                        user.save
                    end
                    @owners = [attorney, adjuster]
                end
                it "must not have the owner's email" do
                    @owners.each do |owner|
                        @visitors.each do |member|
                            sign_in member
                            visit user_profile_show_path(owner.profile)
                            expect(page).to_not have_text "Email"
                            expect(page).to_not have_text owner.email                            
                        end
                    end
                end
            end
        end

        # Iterate through attributes
        context "and the visitor is a separate organization" do
            context "and the owner has profile settings set to show their email to the public" do
                it "must have the owner's email" do
                    pending "Implementation"
                    fail
                end
            end
            context "and the owner has profile settings set to show their email to members of the same organization only" do
                it "must not have the owner's email" do
                    pending "Implementation"
                    fail
                end
            end
            context "and the owner has profile settings set to show their email to nobody" do
                it "must not have the owner's email" do
                    pending "Implementation"
                    fail
                end
            end
        end
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    # context "when the owner is a member-type user" do
    #     context "with profile settings set to show the Last name to members of the same organization only" do
    #         before :context do
    #             attorney = create(:attorney) do |user|
    #                 user.settings.profile.show_last_name_to_members_only = true
    #                 user.settings.profile.save
    #             end
    #             extra_attorney = create(:attorney, organization: attorney.organization)
    #             adjuster = create(:adjuster) do |user|
    #                 user.settings.profile.show_last_name_to_members_only = true
    #                 user.settings.profile.save
    #             end
    #             extra_adjuster = create(:adjuster, organization: adjuster.organization)
    #             @owners = [attorney, adjuster]
    #             @extras = [extra_attorney, extra_adjuster]
    #         end
    #         after :context do
    #             @owners.each {|owner| owner.destroy} 
    #             @extras.each {|extra| extra.destroy}
    #         end
    #         context "and the user is a member of the same organization" do
    #             it "must have the owner's Last name" do
    #                 @owners.each do |owner|
    #                     @extras.each do |extra|
    #                         expect(extra.organization.name).to eq owner.organization.name
    #                         expect(extra.organization.id).to eq owner.organization.id
    #                         expect(extra.organization.id.nil?).to eq false
    #                         sign_in extra
    #                         visit user_profile_show_path(owner.profile)
    #                         expect(page).to have_text owner.profile.name, wait: 15
    #                     end
    #                 end
    #             end
    #         end
    #         context "and the user is not a member of the same organization" do
    #             it "must not have the owner's Last name" do
    #                 @owners.each do |owner|
    #                     @users.each do |user|
    #                         sign_in user
    #                         visit user_profile_show_path(owner.profile)
    #                         expect(page).to_not have_text "Last name"
    #                         expect(page).to_not have_text owner.profile.name
    #                     end
    #                 end
    #             end
    #         end
    #     end
    #     context "with profile settings set to show the Last name to the public" do
    #         before :context do
    #             attorney = build(:attorney) do |user|
    #                 user.settings = build(:user_settings)
    #                 user.settings.profile = build(:user_profile_settings, show_last_name_to_members_only: true)
    #                 user.save
    #             end
    #             extra_attorney = create(:attorney, organization: attorney.organization)
    #             adjuster = build(:adjuster) do |user|
    #                 user.settings = build(:user_settings)
    #                 user.settings.profile = build(:user_profile_settings, show_last_name_to_members_only: true)
    #                 user.save
    #             end
    #             extra_adjuster = create(:adjuster, organization: adjuster.organization)
    #             @owners = [attorney, adjuster]
    #             @extras = [extra_attorney, extra_adjuster]
    #         end
    #         after :context do
    #             @owners.each {|owner| owner.destroy} 
    #             @extras.each {|extra| extra.destroy}
    #         end
    #         it "must have the owner's Last name" do
    #             @owners.each do |owner|
    #                 @users.each do |user|
    #                     sign_in user
    #                     visit user_profile_show_path(owner.profile)
    #                     expect(page).to have_text owner.profile.name
    #                 end
    #                 @extras.each do |extra|
    #                     sign_in extra
    #                     visit user_profile_show_path(owner.profile)
    #                     expect(page).to have_text owner.profile.name
    #                 end
    #             end
    #         end
    #     end
    #     context "with profile settings set to show the last name to nobody" do
    #         context "and the user is a member of the same organization" do
    #             it "must not have the owner's Last name" do
    #                 @owners.each do |owner|
    #                     user = create(owner.role.to_sym, ApplicationHelper.organization_role_name(owner).to_sym => owner.organization)
    #                     sign_in user
    #                     visit user_profile_show_path(owner.profile)
    #                     expect(page).to_not have_text "Last name"
    #                     expect(page).to_not have_text owner.profile.name
    #                 end
    #             end
    #         end
    #         context "and the user is not a member of the same organization" do
    #             it "must not have the owner's Last name" do
    #                 @owners.each do |owner|
    #                     @users.each do |user|
    #                         sign_in user
    #                         visit user_profile_show_path(owner.profile)
    #                         expect(page).to_not have_text "Last name"
    #                         expect(page).to_not have_text owner.profile.name
    #                     end
    #                 end
    #             end
    #         end
    #     end
    # end
end