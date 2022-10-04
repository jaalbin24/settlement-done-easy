require 'rails_helper'

RSpec.describe "The User Factory" do
    context "when creating a law_firm model" do
        it "must create exactly one law_firm" do
            expect(User.law_firms.size).to eq(0)
            create(:law_firm)
            expect(User.law_firms.size).to eq(1)
        end
        it "must create exactly one attorney" do
            expect(User.attorneys.size).to eq(0)
            create(:law_firm)
            expect(User.attorneys.size).to eq(1)
        end
        it "must create exactly one bank account" do
            expect(BankAccount.all.size).to eq(0)
            create(:law_firm)
            expect(BankAccount.all.size).to eq(1)
        end
        it "must create exactly one stripe account" do
            expect(StripeAccount.all.size).to eq(0)
            create(:law_firm)
            expect(StripeAccount.all.size).to eq(1)
        end
        it "must not create any settlements" do
            expect(Settlement.all.size).to eq(0)
            create(:law_firm)
            expect(Settlement.all.size).to eq(0)
        end
    end

    context "when creating an attorney model" do
        it "must create exactly one law_firm" do
            expect(User.law_firms.size).to eq(0)
            create(:attorney)
            expect(User.law_firms.size).to eq(1)
        end
        it "must create exactly one attorney" do
            expect(User.attorneys.size).to eq(0)
            create(:attorney)
            expect(User.attorneys.size).to eq(1)
        end
        it "must not create any settlements" do
            expect(Settlement.all.size).to eq(0)
            create(:attorney)
            expect(Settlement.all.size).to eq(0)
        end
    end

    context "when creating an insurance company model" do
        it "must create exactly one insurance company" do
            expect(User.insurance_companies.size).to eq(0)
            create(:insurance_company)
            expect(User.insurance_companies.size).to eq(1)
        end
        it "must create exactly one adjuster" do
            expect(User.insurance_agents.size).to eq(0)
            create(:insurance_company)
            expect(User.insurance_agents.size).to eq(1)
        end
        it "must create exactly one bank account" do
            expect(BankAccount.all.size).to eq(0)
            create(:insurance_company)
            expect(BankAccount.all.size).to eq(1)
        end
        it "must create exactly one stripe account" do
            expect(StripeAccount.all.size).to eq(0)
            create(:insurance_company)
            expect(StripeAccount.all.size).to eq(1)
        end
        it "must not create any settlements" do
            expect(Settlement.all.size).to eq(0)
            create(:insurance_company)
            expect(Settlement.all.size).to eq(0)
        end
    end

    context "when creating an adjuster model" do
        it "must create exactly one insurance company" do
            expect(User.insurance_companies.size).to eq(0)
            create(:adjuster)
            expect(User.insurance_companies.size).to eq(1)
        end
        it "must create exactly one adjuster" do
            expect(User.insurance_agents.size).to eq(0)
            create(:adjuster)
            expect(User.insurance_agents.size).to eq(1)
        end
        it "must not create any settlements" do
            expect(Settlement.all.size).to eq(0)
            create(:adjuster)
            expect(Settlement.all.size).to eq(0)
        end
    end
end