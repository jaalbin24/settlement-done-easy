Rspec.describe "The requirements page" do
    include_context "devise"
    context "when MFA is enabled" do
        before do
            @user = create(:law_firm)
            sign_in @user
            visit requirements_path
        end
        it "must open the password confirmation modal" do
            pending "Implementation"
            fail
        end
        it "must have a checked box icon next to the 'Enable MFA' requirement" do
            pending "Implementation"
            fail
        end
        it "must not do anything when 'Enable MFA' is clicked" do
            pending "Implementation"
            fail
        end
        it "must show the right tooltip when hovering over the 'Enable MFA' requirement" do
            pending "Implementation"
            fail
        end
    end
    context "when MFA is disabled" do
        it "must have an unchecked box icon next to the 'Enable MFA' requirement" do
            pending "Implementation"
            fail
        end
        it "must open the MFA activation modal when the 'Enable MFA' requirement is clicked" do
            pending "Implementation"
            fail
        end
        it "must show the right tooltip when hovering over the 'Enable MFA' requirement" do
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