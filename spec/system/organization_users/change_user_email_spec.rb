require "rails_helper"

RSpec.describe "The change email page" do
    include_context "devise"
    it "must have a field to enter the new email" do
        pending "This test can be written right now!"
        fail
    end
    it "must have a field to enter the user's current password" do
        pending "This test can be written right now!"
        fail
    end
    it "must have a button labeled 'Submit'" do
        pending "This test can be written right now!"
        fail
    end
    context "after the 'Submit' button is pressed" do
        context "if the current password was incorrect" do
            it "must style the current password input field red" do
                pending "This test can be written right now!"
                fail
            end
            it "must reenable the 'Submit' button" do
                pending "This test can be written right now!"
                fail
            end
            it "must show a message saying the password was incorrect" do
                pending "This test can be written right now!"
                fail
            end
        end
        context "if the new email was incorrectly formatted" do
            it "must style the email input field red" do
                pending "This test can be written right now!"
                fail
            end
            it "must reenable the 'Submit' button" do
                pending "This test can be written right now!"
                fail
            end
            it "must show a message saying the email is not valid" do
                pending "This test can be written right now!"
                fail
            end
        end
        context "if the new email is already taken" do
            it "must style the email input field red" do
                pending "This test can be written right now!"
                fail
            end
            it "must reenable the 'Submit' button" do
                pending "This test can be written right now!"
                fail
            end
            it "must show a message saying the email is already taken" do
                pending "This test can be written right now!"
                fail
            end
        end
        context "if the update succeeded" do
            it "must take the user to the account section of the settings page" do
                pending "This test can be written right now!"
                fail
            end
            it "must show a flash message saying the email was changed" do
                pending "This test can be written right now!"
                fail
            end
        end
    end
end