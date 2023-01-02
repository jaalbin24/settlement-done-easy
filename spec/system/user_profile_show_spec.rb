require "rails_helper"
# The 'owner' refers to the user that the profile represents. If a profile page for John Smith is being accessed, John Smith is the owner.
RSpec.describe "The user profile page", type: :system do
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

    context "when the owner is an organization-type user" do
        context "with profile settings set to hide the owner's MCC from its members" do
            context "and the user is a member belonging to that organization" do
                it "must not have the owner's MCC" do
                    pending "Implementation"
                    fail
                end
            end
            context "and the user is not a member belonging to that organization" do
                it "must not have the owner's MCC" do
                    pending "Implementation"
                    fail
                end
            end
        end
        context "with profile settings set to show the owner's MCC to its members" do
            context "and the user is a member belonging to that organization" do
                it "must have the owner's MCC" do
                    pending "Implementation"
                    fail
                end
            end
            context "and the user is not a member belonging to that organization" do
                context "and the owner has profile settings set to show the owner's MCC to the public"
                    it "must have the owner's MCC" do
                        pending "Implementation"
                        fail
                    end
                end
                context "and the owner has profile settings set to hide the owner's MCC from the public"
                    it "must have the owner's MCC" do
                        pending "Implementation"
                        fail
                    end
                end
            end
        end











        
        context "with profile settings set to show the owner's MCC" do

        end
        
        it "must have the owner's public name" do
            pending "Implementation"
            fail
        end
        it "must have the owner's legal name" do
            pending "Implementation"
            fail
        end
        it "must have the owner's phone number" do
            pending "Implementation"
            fail
        end
        it "must have the owner's email" do
            pending "Implementation"
            fail
        end
        it "must have the owner's address" do
            pending "Implementation"
            fail
        end
        it "must have the owner's MCC" do
            pending "Implementation"
            fail
        end
        it "must have the owner's tax ID" do
            pending "Implementation"
            fail
        end
        it "must have the owner's product description" do
            pending "Implementation"
            fail
        end
        it "must not have the owner's date of birth" do
            pending "Implementation"
            fail
        end
        it "must not have the owner's relationship to business" do
            pending "Implementation"
            fail
        end
        it "must not have the last 4 digits of the owner's SSN" do
            pending "Implementation"
            fail
        end
        it "must not have the owner's percent ownership" do
            pending "Implementation"
            fail
        end
        it "must not have the owner's first name" do
            pending "Implementation"
            fail
        end
        it "must not have the owner's last name" do
            pending "Implementation"
            fail
        end
    end

    context "when the owner is a member-type user" do
        it "must not have the owner's public name" do
            pending "Implementation"
            fail
        end
        it "must not have the owner's legal name" do
            pending "Implementation"
            fail
        end
        it "must not have the owner's MCC" do
            pending "Implementation"
            fail
        end
        it "must not have the owner's tax ID" do
            pending "Implementation"
            fail
        end
        it "must not have the owner's product description" do
            pending "Implementation"
            fail
        end
        it "must have the owner's date of birth" do
            pending "Implementation"
            fail
        end
        it "must have the owner's relationship to business" do
            pending "Implementation"
            fail
        end
        it "must have the last 4 digits of the owner's SSN" do
            pending "Implementation"
            fail
        end
        it "must have the owner's percent ownership" do
            pending "Implementation"
            fail
        end
        it "must have the owner's first name" do
            pending "Implementation"
            fail
        end
        it "must have the owner's last name" do
            pending "Implementation"
            fail
        end
        it "must have the owner's phone number" do
            pending "Implementation"
            fail
        end
        it "must have the owner's email" do
            pending "Implementation"
            fail
        end
        it "must have the owner's address" do
            pending "Implementation"
            fail
        end
    end

    context "when accessed by anyone other than the owner or the owner's organization" do
        it "must not have an edit button" do
            pending "Implementation"
            fail
        end
        context "if the owner has settings set to hide their email" do
            it "must not show the owner's email" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their phone number" do
            it "must not show the owner's phone number" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their address" do
            it "must not show the owner's address" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their birthday" do
            it "must not show the owner's birthday" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their percent ownership" do
            it "must not show the owner's percent ownership" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their position title" do
            it "must not show the owner's position title" do
                pending "Implementation"
                fail
            end
        end
    end

    context "when accessed by the owner" do
        it "must have an edit button that leads to the user profile edit page" do
            @users.each do |user|
                sign_in user
                visit user_profile_show_path(user.profile)
                expect(page).to have_css "a.btn.btn-secondary[href='#{user_profile_edit_path(user.profile, continue_path: user_profile_show_path(user.profile))}']"
                expect(page).to have_link "Edit profile"
                click_on "Edit profile"
                sleep 0.05
                expect(current_path).to eq user_profile_edit_path(user.profile)
            end
        end
        context "if the owner has settings set to hide their email" do
            it "must still show the owner's email" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their email" do
            it "must show the owner's email" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their phone number" do
            it "must still show the owner's phone number" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their phone number" do
            it "must show the owner's phone number" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their address" do
            it "must still show the owner's address" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their address" do
            it "must show the owner's address" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their birthday" do
            it "must still show the owner's birthday" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their birthday" do
            it "must show the owner's birthday" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their percent ownership" do
            it "must still show the owner's percent ownership" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their percent ownership" do
            it "must show the owner's percent ownership" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their position title" do
            it "must still show the owner's position title" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their position title" do
            it "must still show the owner's position title" do
                pending "Implementation"
                fail
            end
        end
    end

    context "when accessed by the owner's organization" do
        it "must have an edit button that leads to the user profile edit page" do
            @users.each do |user|
                sign_in user
                visit user_profile_show_path(user.profile)
                expect(page).to have_css "a.btn.btn-secondary[href='#{user_profile_edit_path(user.profile, continue_path: user_profile_show_path(user.profile))}']"
                expect(page).to have_link "Edit profile"
                click_on "Edit profile"
                sleep 0.05
                expect(current_path).to eq user_profile_edit_path(user.profile)
            end
        end
        context "if the owner has settings set to hide their email" do
            it "must still show the owner's email" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their email" do
            it "must show the owner's email" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their phone number" do
            it "must still show the owner's phone number" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their phone number" do
            it "must show the owner's phone number" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their address" do
            it "must still show the owner's address" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their address" do
            it "must show the owner's address" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their birthday" do
            it "must still show the owner's birthday" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their birthday" do
            it "must show the owner's birthday" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their percent ownership" do
            it "must still show the owner's percent ownership" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their percent ownership" do
            it "must show the owner's percent ownership" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their position title" do
            it "must still show the owner's position title" do
                pending "Implementation"
                fail
            end
            it "must have a tag saying the information is private" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to show their position title" do
            it "must still show the owner's position title" do
                pending "Implementation"
                fail
            end
        end
    end

    context "when the profile does not have a user account" do
        it "must have a button labeled 'Create account'" do
            pending "Implementation"
            fail
        end
        it "must have a message saying the profile does not have a user account" do
            pending "Implementation"
            fail
        end
    end

    context "after the 'Edit profile' button is clicked" do
        it "must take the user to the edit profile page" do
            pending "Implementation"
            fail
        end
    end
end