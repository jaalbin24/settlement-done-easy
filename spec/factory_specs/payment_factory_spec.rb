require 'rails_helper'

RSpec.describe "The Payment Factory" do
    context "when building a payment model" do

    end

    context "when creating a payment model from the ground up" do
        it "must create exactly one payment" do
            expect(Payment.all.size).to eq(0)
            create(:payment, :from_the_ground_up)
            expect(Payment.all.size).to eq(1)
        end
        it "must create exactly one settlement" do
            expect(Settlement.all.size).to eq(0)
            create(:payment, :from_the_ground_up)
            expect(Settlement.all.size).to eq(1)
        end
        it "must create exactly one law firm" do
            expect(User.law_firms.size).to eq(0)
            create(:payment, :from_the_ground_up)
            expect(User.law_firms.size).to eq(1)
        end
        it "must create exactly one insurance company" do
            expect(User.insurance_companies.size).to eq(0)
            create(:payment, :from_the_ground_up)
            expect(User.insurance_companies.size).to eq(1)
        end
        it "must create exactly one attorney" do
            expect(User.attorneys.size).to eq(0)
            create(:payment, :from_the_ground_up)
            expect(User.attorneys.size).to eq(1)
        end
        it "must create exactly one insurance agent" do
            expect(User.insurance_agents.size).to eq(0)
            create(:payment, :from_the_ground_up)
            expect(User.insurance_agents.size).to eq(1)
        end
        it "must create exactly two stripe accounts" do
            expect(StripeAccount.all.size).to eq(0)
            create(:payment, :from_the_ground_up)
            expect(StripeAccount.all.size).to eq(2)
        end
        it "must create exactly two bank accounts" do
            expect(BankAccount.all.size).to eq(0)
            create(:payment, :from_the_ground_up)
            expect(BankAccount.all.size).to eq(2)
        end
    end
end