require 'rails_helper'

RSpec.describe "The User Factory" do
    context "when creating a law_firm model" do
        it "must create exactly one law_firm" do
            expect(User.law_firms.count).to eq(0)
            create(:law_firm)
            expect(User.law_firms.count).to eq(1)
        end
        it "must create exactly one attorney" do
            expect(User.attorneys.count).to eq(0)
            create(:law_firm)
            expect(User.attorneys.count).to eq(1)
        end
        it "must create exactly one bank account" do
            expect(BankAccount.all.count).to eq(0)
            create(:law_firm)
            expect(BankAccount.all.count).to eq(1)
        end
        it "must create exactly one stripe account" do
            expect(StripeAccount.all.count).to eq(0)
            create(:law_firm)
            expect(StripeAccount.all.count).to eq(1)
        end
        it "must not create any settlements" do
            expect(Settlement.all.count).to eq(0)
            create(:law_firm)
            expect(Settlement.all.count).to eq(0)
        end
    end

    context "when creating an attorney model" do
        it "must create exactly one law_firm" do
            expect(User.law_firms.count).to eq(0)
            create(:attorney)
            expect(User.law_firms.count).to eq(1)
        end
        it "must create exactly one attorney" do
            expect(User.attorneys.count).to eq(0)
            create(:attorney)
            expect(User.attorneys.count).to eq(1)
        end
        it "must not create any settlements" do
            expect(Settlement.all.count).to eq(0)
            create(:attorney)
            expect(Settlement.all.count).to eq(0)
        end
        context "with an unactivated organization" do
            context "due to a lack of a bank account" do
                it "must create exactly one law_firm" do
                    expect(User.law_firms.count).to eq(0)
                    create(:attorney, :with_unactivated_organization_due_to_lack_of_bank_account)
                    expect(User.law_firms.count).to eq(1)
                end
                it "must create a deactivated law_firm" do
                    expect(User.law_firms.not_activated.count).to eq(0)
                    create(:attorney, :with_unactivated_organization_due_to_lack_of_bank_account)
                    expect(User.law_firms.not_activated.count).to eq(1)
                end
                it "must create exactly one attorney" do
                    expect(User.attorneys.count).to eq(0)
                    create(:attorney, :with_unactivated_organization_due_to_lack_of_bank_account)
                    expect(User.attorneys.count).to eq(1)
                end
                it "must not create any settlements" do
                    expect(Settlement.all.count).to eq(0)
                    create(:attorney, :with_unactivated_organization_due_to_lack_of_bank_account)
                    expect(Settlement.all.count).to eq(0)
                end
                it "must not create any bank accounts" do
                    expect(BankAccount.all.count).to eq(0)
                    create(:attorney, :with_unactivated_organization_due_to_lack_of_bank_account)
                    expect(BankAccount.all.count).to eq(0)
                end
            end
        end
    end

    context "when creating an insurance company model" do
        it "must create exactly one insurance company" do
            expect(User.insurance_companies.count).to eq(0)
            create(:insurance_company)
            expect(User.insurance_companies.count).to eq(1)
        end
        it "must create exactly one adjuster" do
            expect(User.insurance_agents.count).to eq(0)
            create(:insurance_company)
            expect(User.insurance_agents.count).to eq(1)
        end
        it "must create exactly one bank account" do
            expect(BankAccount.all.count).to eq(0)
            create(:insurance_company)
            expect(BankAccount.all.count).to eq(1)
        end
        it "must create exactly one stripe account" do
            expect(StripeAccount.all.count).to eq(0)
            create(:insurance_company)
            expect(StripeAccount.all.count).to eq(1)
        end
        it "must not create any settlements" do
            expect(Settlement.all.count).to eq(0)
            create(:insurance_company)
            expect(Settlement.all.count).to eq(0)
        end
    end

    context "when creating an adjuster model" do
        it "must create exactly one insurance company" do
            expect(User.insurance_companies.count).to eq(0)
            create(:adjuster)
            expect(User.insurance_companies.count).to eq(1)
        end
        it "must create exactly one adjuster" do
            expect(User.insurance_agents.count).to eq(0)
            create(:adjuster)
            expect(User.insurance_agents.count).to eq(1)
        end
        it "must not create any settlements" do
            expect(Settlement.all.count).to eq(0)
            create(:adjuster)
            expect(Settlement.all.count).to eq(0)
        end
    end
end