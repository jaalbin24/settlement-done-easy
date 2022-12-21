require "rails_helper"

RSpec.describe "The requirements page" do
    include_context "devise"
    describe "in the 'Enable MFA' checklist item" do
        context "if MFA is enabled" do
            before do
                @user = create(:law_firm)
                sign_in @user
                visit requirements_path
                @mfa_checklist_item = find("div.card[id='mfa_checklist_item']")
            end
            it "must have a green checkmark icon" do
                expect(@mfa_checklist_item).to have_css "i.text-success.h1.fa-square-check.fa-solid"
            end
            it "must have grey strikethrough text" do
                expect(@mfa_checklist_item).to have_css "h4.text-muted[id='mfa_checklist_item_title'] del"
                expect(@mfa_checklist_item).to have_css "p.text-muted[id='mfa_checklist_item_subtitle'] del"
            end
            it "must have a css opacity of 50%" do
                expect(page).to have_css "div.card[id='mfa_checklist_item'][style='opacity: 50%;']"
            end
            context "after the MFA checklist item is clicked" do
                it "must take the user to the enable MFA page" do
                    pending "Implementation"
                    fail
                end
            end
        end
        context "if MFA is disabled" do
            before do
                @user = create(:law_firm, )
                sign_in @user
                visit requirements_path
                @mfa_checklist_item = find("div.card[id='mfa_checklist_item']")
            end
            it "must have a grey empty box icon" do
                pending "MFA Implementation"
                expect(@mfa_checklist_item).to have_css "i.text-muted.h1.fa-square.fa-regular"
            end
            it "must not have grey strikethrough text" do
                pending "MFA Implementation"
                expect(@mfa_checklist_item).to have_css "h4[id='mfa_checklist_item_title']"
                expect(@mfa_checklist_item).to have_css "p.text-muted[id='mfa_checklist_item_subtitle']"
                expect(@mfa_checklist_item).to_not have_css "h4 del"
                expect(@mfa_checklist_item).to_not have_css "p del"
            end
            it "must not have a css opacity of 50%" do
                pending "MFA Implementation"
                expect(page).to_not have_css "div.card[id='mfa_checklist_item'][style='opacity: 50%;']"
            end
            context "after the MFA checklist item is clicked" do
                it "must take the user to the enable MFA page" do
                    pending "Implement the MFA page"
                    fail
                end
            end
        end
    end
    describe "in the 'Add Bank Account' checklist item" do
        context "when the user has a bank account" do
            before do
                @user = create(:law_firm)
                sign_in @user
                visit requirements_path
                @add_ba_checklist_item = find("div.card[id='add_ba_checklist_item']")
            end
            it "must have a green checkmark icon" do
                expect(@add_ba_checklist_item).to have_css "i.text-success.h1.fa-square-check.fa-solid"
            end
            it "must have grey strikethrough text" do
                expect(@add_ba_checklist_item).to have_css "h4.text-muted[id='add_ba_checklist_item_title'] del"
                expect(@add_ba_checklist_item).to have_css "p.text-muted[id='add_ba_checklist_item_subtitle'] del"
            end
            it "must have a css opacity of 50%" do
                expect(page).to have_css "div.card[id='add_ba_checklist_item'][style='opacity: 50%;']"
            end
            context "after the 'Add Bank Account' checklist item is clicked" do
                before do
                    @user = create(:law_firm)
                    sign_in @user
                    visit requirements_path
                    @add_ba_checklist_item = find("div.card[id='add_ba_checklist_item']")
                    find("div[id='add_ba_checklist_item']").click
                end
                it "must keep the user on the same page" do
                    expect(current_path).to eq requirements_path
                end
                it "must show a flash message saying the user already has a bank account" do
                    pending "Implementation"
                    expect(page).to have_text "You've already added a bank account. If you want to add another one, click here."
                    fail
                end
            end
        end
        context "when the user does not have a bank account" do
            before do
                @user = create(:law_firm, :not_activated_due_to_lack_of_bank_account)
                sign_in @user
                visit requirements_path
                @add_ba_checklist_item = find("div.card[id='add_ba_checklist_item']")
            end
            it "must have a grey empty box icon" do
                expect(@add_ba_checklist_item).to have_css "i.text-muted.h1.fa-square.fa-regular"
            end
            it "must not have grey strikethrough text" do
                expect(@add_ba_checklist_item).to have_css "h4[id='add_ba_checklist_item_title']"
                expect(@add_ba_checklist_item).to have_css "p.text-muted[id='add_ba_checklist_item_subtitle']"
                expect(@add_ba_checklist_item).to_not have_css "h4 del"
                expect(@add_ba_checklist_item).to_not have_css "p del"
            end
            it "must not have a css opacity of 50%" do
                expect(page).to_not have_css "div.card[id='add_ba_checklist_item'][style='opacity: 50%;']"
            end
            context "after the 'Add Bank Account' checklist item is clicked" do
                before do
                    @user = create(:law_firm, :not_activated_due_to_lack_of_bank_account)
                    sign_in @user
                    visit requirements_path
                    @add_ba_checklist_item = find("div.card[id='add_ba_checklist_item']")
                    find("div[id='add_ba_checklist_item']").click
                end
                it "must open Stripe's bank account modal" do
                    pending "Implementation"
                    fail
                end
            end
        end
    end
    describe "in the 'Onboard Stripe Account' checklist item" do
        context "when the user's Stripe account is onboarded" do
            before do
                @user = create(:law_firm)
                sign_in @user
                visit requirements_path
                @onboard_stripe_checklist_item = find("div.card[id='onboard_stripe_checklist_item']")
            end
            it "must have a green checkmark icon" do
                expect(@onboard_stripe_checklist_item).to have_css "i.text-success.h1.fa-square-check.fa-solid"
            end
            it "must have grey strikethrough text" do
                expect(@onboard_stripe_checklist_item).to have_css "h4.text-muted[id='onboard_stripe_checklist_item_title'] del"
                expect(@onboard_stripe_checklist_item).to have_css "p.text-muted[id='onboard_stripe_checklist_item_subtitle'] del"
            end
            it "must have a css opacity of 50%" do
                expect(page).to have_css "div.card[id='onboard_stripe_checklist_item'][style='opacity: 50%;']"
            end
            context "after the 'Onboard Stripe Account' checklist item is clicked" do
                before do
                    @user = create(:law_firm)
                    sign_in @user
                    visit requirements_path
                    @onboard_stripe_checklist_item = find("div.card[id='onboard_stripe_checklist_item']")
                    find("div[id='add_ba_checklist_item']").click
                end
                it "must keep the user on the same page" do
                    expect(current_path).to eq requirements_path
                end
                it "must show a flash message saying the user's Stripe account has already been onboarded" do
                    pending "Implementation"
                    expect(page).to have_text "You have already completed onboarding with Stripe."
                    fail
                end
            end
        end
        context "when the user's Stripe account is not onboarded" do
            before do
                @user = create(:law_firm, :not_activated_due_to_lack_of_onboarded_stripe_account)
                sign_in @user
                visit requirements_path
                @onboard_stripe_checklist_item = find("div.card[id='onboard_stripe_checklist_item']")
            end
            it "must have a grey empty box icon" do
                expect(@onboard_stripe_checklist_item).to have_css "i.text-muted.h1.fa-square.fa-regular"
            end
            it "must not have grey strikethrough text" do
                expect(@onboard_stripe_checklist_item).to have_css "h4[id='onboard_stripe_checklist_item_title']"
                expect(@onboard_stripe_checklist_item).to have_css "p.text-muted[id='onboard_stripe_checklist_item_subtitle']"
                expect(@onboard_stripe_checklist_item).to_not have_css "h4 del"
                expect(@onboard_stripe_checklist_item).to_not have_css "p del"
            end
            it "must not have a css opacity of 50%" do
                expect(page).to_not have_css "div.card[id='onboard_stripe_checklist_item'][style='opacity: 50%;']"
            end
            context "after the 'Onboard Stripe Account' checklist item is clicked" do
                before do
                    @user = create(:law_firm, :not_activated_due_to_lack_of_onboarded_stripe_account)
                    sign_in @user
                    visit requirements_path
                    @onboard_stripe_checklist_item = find("div.card[id='onboard_stripe_checklist_item']")
                    find("div[id='onboard_stripe_checklist_item']").click
                end
                it "must redirect the user to the Stripe onboarding website" do
                    pending "Implementation"
                    expect(page).to have_text "Settlement Done Easy partners with Stripe for secure financial services."
                end
            end
        end
    end
    describe "in the 'Add a Member' checklist item" do
        context "when the user has at least one member account" do
            before do
                @user = create(:law_firm)
                sign_in @user
                visit requirements_path
                @add_member_checklist_item = find("div.card[id='add_member_checklist_item']")
            end
            it "must have a green checkmark icon" do
                expect(@add_member_checklist_item).to have_css "i.text-success.h1.fa-square-check.fa-solid"
            end
            it "must have grey strikethrough text" do
                expect(@add_member_checklist_item).to have_css "h4.text-muted[id='add_member_checklist_item_title'] del"
                expect(@add_member_checklist_item).to have_css "p.text-muted[id='add_member_checklist_item_subtitle'] del"
            end
            it "must have a css opacity of 50%" do
                expect(page).to have_css "div.card[id='add_member_checklist_item'][style='opacity: 50%;']"
            end
            context "after the 'Add a Member' checklist item is clicked" do
                before do
                    @user = create(:law_firm)
                    sign_in @user
                    visit requirements_path
                    @add_member_checklist_item = find("div.card[id='add_member_checklist_item']")
                    find("div[id='add_member_checklist_item']").click
                end
                it "must keep the user on the same page" do
                    expect(current_path).to eq requirements_path
                end
                it "must show a flash message saying the user already has a member account" do
                    pending "Implementation"
                    expect(page).to have_text "You already have a member account, but if you want to create another, click here."
                end
            end
        end
        context "when the user does not have any members" do
            before do
                @user = create(:law_firm, :not_activated_due_to_lack_of_members)
                sign_in @user
                visit requirements_path
                @add_member_checklist_item = find("div.card[id='add_member_checklist_item']")
            end
            it "must have a grey empty box icon" do
                expect(@add_member_checklist_item).to have_css "i.text-muted.h1.fa-square.fa-regular"
            end
            it "must not have grey strikethrough text" do
                expect(@add_member_checklist_item).to have_css "h4[id='add_member_checklist_item_title']"
                expect(@add_member_checklist_item).to have_css "p.text-muted[id='add_member_checklist_item_subtitle']"
                expect(@add_member_checklist_item).to_not have_css "h4 del"
                expect(@add_member_checklist_item).to_not have_css "p del"
            end
            it "must not have a css opacity of 50%" do
                expect(page).to_not have_css "div.card[id='add_member_checklist_item'][style='opacity: 50%;']"
            end
            context "after the 'Add a Member' checklist item is clicked" do
                before do
                    @user = create(:law_firm, :not_activated_due_to_lack_of_members)
                    sign_in @user
                    visit requirements_path
                    @add_member_checklist_item = find("div.card[id='add_member_checklist_item']")
                    find("div[id='add_member_checklist_item']").click
                end
                it "must redirect the user to the new member page" do
                    pending "Implementation"
                    fail
                end
            end
        end
    end
    describe "in the 'Verify Your Email' checklist item" do
        context "when the user's email is verified" do
            before do
                @user = create(:law_firm)
                sign_in @user
                visit requirements_path
                @verify_email_checklist_item = find("div.card[id='verify_email_checklist_item']")
            end
            it "must have a green checkmark icon" do
                expect(@verify_email_checklist_item).to have_css "i.text-success.h1.fa-square-check.fa-solid"
            end
            it "must have grey strikethrough text" do
                expect(@verify_email_checklist_item).to have_css "h4.text-muted[id='verify_email_checklist_item_title'] del"
                expect(@verify_email_checklist_item).to have_css "p.text-muted[id='verify_email_checklist_item_subtitle'] del"
            end
            it "must have a css opacity of 50%" do
                expect(page).to have_css "div.card[id='verify_email_checklist_item'][style='opacity: 50%;']"
            end
            context "after the 'Verify Your Email' checklist item is clicked" do
                before do
                    @user = create(:law_firm)
                    sign_in @user
                    visit requirements_path
                    @verify_email_checklist_item = find("div.card[id='verify_email_checklist_item']")
                    find("div[id='verify_email_checklist_item']").click
                end
                it "must keep the user on the same page" do
                    expect(current_path).to eq requirements_path
                end
                it "must show a flash message saying the user already verified their email" do
                    pending "Implementation"
                    expect(page).to have_text "Your email #{@user.email} is already verified."
                end
            end
        end
        context "when the user's email is not verified" do
            before do
                @user = create(:law_firm) # not_activated_due_to_unverified_email
                sign_in @user
                visit requirements_path
                @verify_email_checklist_item = find("div.card[id='verify_email_checklist_item']")
            end
            it "must have a grey empty box icon" do
                pending "Email verification"
                expect(@verify_email_checklist_item).to have_css "i.text-muted.h1.fa-square.fa-regular"
            end
            it "must not have grey strikethrough text" do
                pending "Email verification"
                expect(@verify_email_checklist_item).to have_css "h4[id='verify_email_checklist_item_title']"
                expect(@verify_email_checklist_item).to have_css "p.text-muted[id='verify_email_checklist_item_subtitle']"
                expect(@verify_email_checklist_item).to_not have_css "h4 del"
                expect(@verify_email_checklist_item).to_not have_css "p del"
            end
            it "must not have a css opacity of 50%" do
                pending "Email verification"
                expect(page).to_not have_css "div.card[id='verify_email_checklist_item'][style='opacity: 50%;']"
            end
            context "after the 'Verify Your Email' checklist item is clicked" do
                before do
                    @user = create(:law_firm) # not_activated_due_to_unverified_email
                    sign_in @user
                    visit requirements_path
                    @verify_email_checklist_item = find("div.card[id='verify_email_checklist_item']")
                    find("div[id='verify_email_checklist_item']").click
                end
                it "must redirect the user to the email verification page" do
                    pending "Implementation"
                    expect(current_path).to eq email_verification_path
                end
            end
        end
    end
end