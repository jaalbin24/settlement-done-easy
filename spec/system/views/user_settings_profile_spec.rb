require "rails_helper"

RSpec.describe "The profile section of the user settings page" do
    include_context "devise"

    it "must have a nav-bar button labeled 'Profile'" do
        pending "Implementation"
        fail
    end
    it "must have a Personal Profile section" do
        pending "Implementation"
        fail
    end
    it "must have a Business Profile section" do
        pending "Implementation"
        fail
    end

    context "in the Personal Profile section" do
        it "must have a button labeled 'Add profile' that opens the new profile modal" do
            pending "Implementation"
            fail
        end
        it "must have an accordion listing all profiles" do
            pending "Implementation"
            fail
        end
        context "in the accordian" do
            it "must expand each accordian item when clicking on it" do
                pending "Implementation"
                fail
            end
            it "must have a field to edit the profile's first name" do
                pending "Implementation"
                fail
            end
            it "must have a field to edit the profile's last name" do
                pending "Implementation"
                fail
            end
            it "must have a field to edit the profile's date of birth" do
                pending "Implementation"
                fail
            end
            it "must have a field to edit the profile's phone number" do
                pending "Implementation"
                fail
            end
            it "must have a field to edit the profile's address" do
                pending "Implementation"
                fail
            end
            it "must have a field to edit the profile's email" do
                pending "Implementation"
                fail
            end
            it "must have a field to edit the profile's relationship to the business" do
                pending "Implementation"
                fail
            end
            it "must have a field to edit the profile's percent ownership of the business" do
                pending "Implementation"
                fail
            end
            it "must have a read-only field showing the profile's SSN" do
                pending "Implementation"
                fail
            end
            it "must have a submit button labeled 'Update [full name]' that submits the form" do
                pending "Implementation"
                fail
            end
            it "must have a button with a trashcan icon that deletes the profile" do
                pending "Implementation"
                fail
            end
        end
        context "in the new profile modal" do
            it "must have a field to enter the profile's first name" do
                pending "Implementation"
                fail
            end
            it "must have a field to enter the profile's last name" do
                pending "Implementation"
                fail
            end
            it "must have a field to enter the profile's date of birth" do
                pending "Implementation"
                fail
            end
            it "must have a field to enter the profile's phone number" do
                pending "Implementation"
                fail
            end
            it "must have a field to enter the profile's address" do
                pending "Implementation"
                fail
            end
            it "must have a field to enter the profile's email" do
                pending "Implementation"
                fail
            end
            it "must have a field to enter the profile's relationship to the business" do
                pending "Implementation"
                fail
            end
            it "must have a field to enter the profile's percent ownership of the business" do
                pending "Implementation"
                fail
            end
            it "must have a submit button labeled 'Add profile' that submits the form" do
                pending "Implementation"
                fail
            end
        end
    end
    context "in the Business Profile section" do
        it "must have a field to edit the business's public name" do
            pending "Implementation"
            fail
        end
        it "must have a read-only field that shows the business's legal name" do
            pending "Implementation"
            fail
        end
        it "must have a read-only field that shows the business's MCC" do
            pending "Implementation"
            fail
        end
        it "must have a field to edit the business's product description" do
            pending "Implementation"
            fail
        end
        it "must have a field to edit the business's address" do
            pending "Implementation"
            fail
        end
        it "must have a field to edit the business's phone number" do
            pending "Implementation"
            fail
        end
        it "must have a read-only field that shows the business's tax id" do
            pending "Implementation"
            fail
        end
        it "must have a submit button labeled 'Update profile' that submits the form" do
            pending "Implementation"
            fail
        end
    end
end