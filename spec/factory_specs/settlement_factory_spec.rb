require 'rails_helper'

RSpec.describe "The Settlement Factory" do
    context "when building a settlement model" do

    end

    context "when creating a settlement model" do
        it "must create exactly one settlement" do
            expect(Settlement.all.size).to eq(0)
            create(:settlement)
            expect(Settlement.all.size).to eq(1)
        end
        it "must create exactly one payment" do
            expect(Payment.all.size).to eq(0)
            create(:settlement)
            expect(Payment.all.size).to eq(1)
        end
        it "must create exactly one law firm" do
            expect(User.law_firms.size).to eq(0)
            create(:settlement)
            expect(User.law_firms.size).to eq(1)
        end
        it "must create exactly one insurance company" do
            expect(User.insurance_companies.size).to eq(0)
            create(:settlement)
            expect(User.insurance_companies.size).to eq(1)
        end
        it "must create exactly one attorney" do
            expect(User.attorneys.size).to eq(0)
            create(:settlement)
            expect(User.attorneys.size).to eq(1)
        end
        it "must create exactly one insurance agent" do
            expect(User.insurance_agents.size).to eq(0)
            create(:settlement)
            expect(User.insurance_agents.size).to eq(1)
        end
        it "must create exactly two stripe accounts" do
            expect(StripeAccount.all.size).to eq(0)
            create(:settlement)
            expect(StripeAccount.all.size).to eq(2)
        end
        it "must create exactly two bank accounts" do
            expect(BankAccount.all.size).to eq(0)
            create(:settlement)
            expect(BankAccount.all.size).to eq(2)
        end
    end
end