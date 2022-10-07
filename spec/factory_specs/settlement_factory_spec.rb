require 'rails_helper'

RSpec.describe "The Settlement Factory" do
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
        it "must create exactly one document review" do
            expect(DocumentReview.all.size).to eq(0)
            create(:settlement)
            expect(DocumentReview.all.size).to eq(2)
        end
        it "must create exactly one document" do
            expect(Document.all.size).to eq(0)
            create(:settlement)
            expect(Document.all.size).to eq(1)
        end
        it "must be referenced by its documents" do
            settlement = create(:settlement)
            expect(settlement.documents.size).to be > 0
            document = settlement.documents.first
            expect(document.settlement).to equal(settlement)
        end
        context "with a processing payment" do
            it "must create a locked settlement" do
                settlement = create(:settlement, :with_processing_payment)
                expect(settlement.locked?).to be_truthy
            end
            it "must create a payment with a status of 'completed'" do
                settlement = create(:settlement, :with_processing_payment)
                expect(settlement.payments.processing.exists?).to be_truthy
            end
            it "must create exactly one settlement" do
                expect(Settlement.all.size).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(Settlement.all.size).to eq(1)
            end
            it "must create exactly one payment" do
                expect(Payment.all.size).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(Payment.all.size).to eq(1)
            end
            it "must create exactly one law firm" do
                expect(User.law_firms.size).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(User.law_firms.size).to eq(1)
            end
            it "must create exactly one insurance company" do
                expect(User.insurance_companies.size).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(User.insurance_companies.size).to eq(1)
            end
            it "must create exactly one attorney" do
                expect(User.attorneys.size).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(User.attorneys.size).to eq(1)
            end
            it "must create exactly one insurance agent" do
                expect(User.insurance_agents.size).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(User.insurance_agents.size).to eq(1)
            end
            it "must create exactly two stripe accounts" do
                expect(StripeAccount.all.size).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(StripeAccount.all.size).to eq(2)
            end
            it "must create exactly two bank accounts" do
                expect(BankAccount.all.size).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(BankAccount.all.size).to eq(2)
            end
            it "must create exactly two document reviews" do
                expect(DocumentReview.all.size).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(DocumentReview.all.size).to eq(2)
            end
        end
        context "with a completed payment" do
            it "must create a locked settlement" do
                settlement = create(:settlement, :with_completed_payment)
                expect(settlement.locked?).to be_truthy
            end
            it "must create a payment with a status of 'completed'" do
                settlement = create(:settlement, :with_completed_payment)
                expect(settlement.payments.completed.exists?).to be_truthy
            end
            it "must create exactly one settlement" do
                expect(Settlement.all.size).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(Settlement.all.size).to eq(1)
            end
            it "must create exactly one payment" do
                expect(Payment.all.size).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(Payment.all.size).to eq(1)
            end
            it "must create exactly one law firm" do
                expect(User.law_firms.size).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(User.law_firms.size).to eq(1)
            end
            it "must create exactly one insurance company" do
                expect(User.insurance_companies.size).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(User.insurance_companies.size).to eq(1)
            end
            it "must create exactly one attorney" do
                expect(User.attorneys.size).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(User.attorneys.size).to eq(1)
            end
            it "must create exactly one insurance agent" do
                expect(User.insurance_agents.size).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(User.insurance_agents.size).to eq(1)
            end
            it "must create exactly two stripe accounts" do
                expect(StripeAccount.all.size).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(StripeAccount.all.size).to eq(2)
            end
            it "must create exactly two bank accounts" do
                expect(BankAccount.all.size).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(BankAccount.all.size).to eq(2)
            end
            it "must create exactly two document reviews" do
                expect(DocumentReview.all.size).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(DocumentReview.all.size).to eq(2)
            end
        end
    end
end