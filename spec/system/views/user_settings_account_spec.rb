require "rails_helper"

RSpec.describe "The account section of the user settings page" do
    include_context "devise"
    it "must have a nav-bar button labeled 'Account'" do
        pending "Implementation"
        fail
    end
    it "must have a Details section" do
        pending "Implementation"
        fail
    end
    it "must have a Requirements section" do
        pending "Implementation"
        fail
    end

    context "in the Details section" do
        it "must have a field to edit the user's email" do
            pending "Implementation"
            fail
        end
        it "must have a field to edit the user's phone number" do
            pending "Implementation"
            fail
        end
        it "must have a button that causes the change password modal to be shown" do
            pending "Implementation"
            fail
        end
        context "when 2FA is enabled" do
            it "must have a link to disable 2FA" do
                pending "Implementation"
                fail
            end
        end
        context "when 2FA is disabled" do
            it "must have a button that opens the 2FA activation modal" do
                pending "Implementation"
                fail
            end
        end
    end

    context "in the Requirements section" do
        context "when 2FA is enabled" do
            it "must have a checked box icon next to the 'Enable 2FA' requirement" do
                pending "Implementation"
                fail
            end
            it "must not do anything when 'Enable 2FA' is clicked" do
                pending "Implementation"
                fail
            end
            it "must show the right tooltip when hovering over the 'Enable 2FA' requirement" do
                pending "Implementation"
                fail
            end
        end
        context "when 2FA is disabled" do
            it "must have an unchecked box icon next to the 'Enable 2FA' requirement" do
                pending "Implementation"
                fail
            end
            it "must open the 2FA activation modal when the 'Enable 2FA' requirement is clicked" do
                pending "Implementation"
                fail
            end
            it "must show the right tooltip when hovering over the 'Enable 2FA' requirement" do
                pending "Implementation"
                fail
            end
        end
        context "when the user has a bank account" do
            it "must have a checked box icon next to the 'Add a bank account' requirement" do
                pending "Implementation"
                fail
            end
            it "must open the Stripe pop-up when the 'Add a bank account' requirement is clicked" do
                pending "Implementation"
                fail
            end
            it "must show the right tooltip when hovering over the 'Add a bank account' requirement" do
                pending "Implementation"
                fail
            end
        end
        context "when the user does not have a bank account" do
            it "must have an unchecked box icon next to the 'Add a bank account' requirement" do
                pending "Implementation"
                fail
            end
            it "must open the Stripe pop-up when the 'Add a bank account' requirement is clicked" do
                pending "Implementation"
                fail
            end
            it "must show the right tooltip when hovering over the 'Add a bank account' requirement" do
                pending "Implementation"
                fail
            end
        end
        context "when the user has an onboarded Stripe account" do
            it "must have a checked box icon next to the 'Complete onboarding with Stripe' requirement" do
                pending "Implementation"
                fail
            end
            it "must not do anything when 'Complete onboarding with Stripe' is clicked" do
                pending "Implementation"
                fail
            end
            it "must show the right tooltip when hovering over the 'Complete onboarding with Stripe' requirement" do
                pending "Implementation"
                fail
            end
        end
        context "when the user does not have an onboarded Stripe account" do
            it "must have an unchecked box icon next to the 'Complete onboarding with Stripe' requirement" do
                pending "Implementation"
                fail
            end
            it "must open the Stripe pop-up when the 'Complete onboarding with Stripe' requirement is clicked" do
                pending "Implementation"
                fail
            end
            it "must show the right tooltip when hovering over the 'Complete onboarding with Stripe' requirement" do
                pending "Implementation"
                fail
            end
        end
        context "when the user has at least one member account" do
            it "must have a checked box icon next to the 'Create a member account' requirement" do
                pending "Implementation"
                fail
            end
            it "must not do anything when 'Create a member account' is clicked" do
                pending "Implementation"
                fail
            end
            it "must show the right tooltip when hovering over the 'Create a member account' requirement" do
                pending "Implementation"
                fail
            end
        end
        context "when the user does not have at least one member account" do
            it "must have an unchecked box icon next to the 'Create a member account' requirement" do
                pending "Implementation"
                fail
            end
            it "must show the new member page when the 'Create a member account' requirement is clicked" do
                pending "Implementation"
                fail
            end
            it "must show the right tooltip when hovering over the 'Create a member account' requirement" do
                pending "Implementation"
                fail
            end
        end 
    end

    context "in the change password modal" do
        it "must have a field to enter the current password" do
            pending "Implementation"
            fail
        end
        it "must have a field to enter the new password" do
            pending "Implementation"
            fail
        end
        it "must have a field to reenter the new password" do
            pending "Implementation"
            fail
        end
        it "must have a submit button labeled 'Change password' that submits the form" do
            pending "Implementation"
            fail
        end
        it "must not allow the form to be submitted when the confirmation password and the new password do not match" do
            pending "Implementation"
            fail
        end
        context "after the 'Change password' button has been pressed" do
            context "if the password was successfully changed" do
                it "must have a message saying the password was changed" do
                    pending "Implementation"
                    fail
                end
                it "must have a button labeled 'Close' that closes the modal" do
                    pending "Implementation"
                    fail
                end
                it "must not have a button labeled 'Change password'" do
                    pending "Implementation"
                    fail
                end
            end
            context "if the current password was not correct" do
                it "must have a message saying the password was incorrect" do
                    pending "Implementation"
                    fail
                end
            end
        end
    end

    context "in the 2FA activation modal" do
        it "must have a tab for authentication via SMS" do
            pending "Implementation"
            fail
        end
        it "must have a tab for authentication via an authenticator app" do
            pending "Implementation"
            fail
        end
        context "in the SMS tab" do
            it "must have directions for the user" do
                pending "Implementation"
                fail
            end
            it "must have a field to enter the user's phone number" do
                pending "Implementation"
                fail
            end
            it "must have a button labeled 'Send code' that submits the phone number form" do
                pending "Implementation"
                fail
            end
            context "after the phone number form is submitted" do
                it "must have directions for the user" do
                    pending "Implementation"
                    fail
                end
                it "must have a field to enter the SMS verification code" do
                    pending "Implementation"
                    fail
                end
                it "must have a button labeled 'Verify' that submits the SMS code form" do
                    pending "Implementation"
                    fail
                end
                context "if phone number verification succeeds" do
                    it "must have directions for the user" do
                        pending "Implementation"
                        fail
                    end
                    it "must have a success message" do
                        pending "Implementation"
                        fail
                    end
                    it "must have a button labeled 'Close'" do
                        pending "Implementation"
                        fail
                    end
                end
                context "if phone number verification fails" do
                    it "must have directions for the user" do
                        pending "Implementation"
                        fail
                    end
                    it "must have a failure message" do
                        pending "Implementation"
                        fail
                    end
                    it "must have a button labeled 'Resend code' that resends the SMS verification code" do
                        pending "Implementation"
                        fail
                    end
                end
                context "if the 'Resend code' button is pressed" do
                    context "and the code is successfully sent" do
                        it "must have a message saying the code was resent" do
                            pending "Implementation"
                            fail
                        end
                    end
                    context "and the verification code fails to send" do
                        it "must have a message saying the code failed to send" do
                            pending "Implementation"
                            fail
                        end
                    end
                end
            end
        end
    end
end