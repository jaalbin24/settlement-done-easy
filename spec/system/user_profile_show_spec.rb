require "rails_helper"
# The 'owner' refers to the user that the profile represents. If a profile page for John Smith is being accessed, John Smith is the owner.
RSpec.describe "The user profile page", type: :system do
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

    before :each do
        @users.each do |user|
            sign_out
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
        it "must have an edit button" do
            pending "Implementation"
            fail
        end
        context "if the owner has settings set to hide their email" do
            it "must show the owner's email" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their phone number" do
            it "must show the owner's phone number" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their address" do
            it "must show the owner's address" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their birthday" do
            it "must show the owner's birthday" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their percent ownership" do
            it "must show the owner's percent ownership" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their position title" do
            it "must show the owner's position title" do
                pending "Implementation"
                fail
            end
        end
    end

    context "when accessed by the owner's organization" do
        it "must have an edit button" do
            pending "Implementation"
            fail
        end
        context "if the owner has settings set to hide their email" do
            it "must show the owner's email" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their phone number" do
            it "must show the owner's phone number" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their address" do
            it "must show the owner's address" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their birthday" do
            it "must show the owner's birthday" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their percent ownership" do
            it "must show the owner's percent ownership" do
                pending "Implementation"
                fail
            end
        end
        context "if the owner has settings set to hide their position title" do
            it "must show the owner's position title" do
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