require 'rails_helper'

RSpec.describe "The Settlement Factory" do
    context "when creating a settlement model" do
        it "must create exactly one settlement" do
            expect(Settlement.all.count).to eq(0)
            create(:settlement)
            expect(Settlement.all.count).to eq(1)
        end
        it "must create exactly one payment" do
            expect(Payment.all.count).to eq(0)
            create(:settlement)
            expect(Payment.all.count).to eq(1)
        end
        it "must create exactly one law firm" do
            expect(User.law_firms.count).to eq(0)
            create(:settlement)
            expect(User.law_firms.count).to eq(1)
        end
        it "must create exactly one insurance company" do
            expect(User.insurance_companies.count).to eq(0)
            create(:settlement)
            expect(User.insurance_companies.count).to eq(1)
        end
        it "must create exactly one attorney" do
            expect(User.attorneys.count).to eq(0)
            create(:settlement)
            expect(User.attorneys.count).to eq(1)
        end
        it "must create exactly one insurance agent" do
            expect(User.insurance_agents.count).to eq(0)
            create(:settlement)
            expect(User.insurance_agents.count).to eq(1)
        end
        it "must create exactly two stripe accounts" do
            expect(StripeAccount.all.count).to eq(0)
            create(:settlement)
            expect(StripeAccount.all.count).to eq(2)
        end
        it "must create exactly two bank accounts" do
            expect(BankAccount.all.count).to eq(0)
            create(:settlement)
            expect(BankAccount.all.count).to eq(2)
        end
        it "must create exactly two document reviews" do
            expect(DocumentReview.all.count).to eq(0)
            create(:settlement)
            expect(DocumentReview.all.count).to eq(2)
        end
        it "must create exactly one document" do
            expect(Document.all.count).to eq(0)
            create(:settlement)
            expect(Document.all.count).to eq(1)
        end
        it "must be referenced by its documents" do
            settlement = create(:settlement)
            expect(settlement.documents.count).to be > 0
            document = settlement.documents.first
            expect(document.settlement.id).to eq(settlement.id)
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
                expect(Settlement.all.count).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(Settlement.all.count).to eq(1)
            end
            it "must create exactly one payment" do
                expect(Payment.all.count).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(Payment.all.count).to eq(1)
            end
            it "must create exactly one law firm" do
                expect(User.law_firms.count).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(User.law_firms.count).to eq(1)
            end
            it "must create exactly one insurance company" do
                expect(User.insurance_companies.count).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(User.insurance_companies.count).to eq(1)
            end
            it "must create exactly one attorney" do
                expect(User.attorneys.count).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(User.attorneys.count).to eq(1)
            end
            it "must create exactly one insurance agent" do
                expect(User.insurance_agents.count).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(User.insurance_agents.count).to eq(1)
            end
            it "must create exactly two stripe accounts" do
                expect(StripeAccount.all.count).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(StripeAccount.all.count).to eq(2)
            end
            it "must create exactly two bank accounts" do
                expect(BankAccount.all.count).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(BankAccount.all.count).to eq(2)
            end
            it "must create exactly one document with status set to 'Approved'" do
                expect(Document.all.count).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(Document.all.count).to eq(1)
                expect(Document.approved.count).to eq(1)
            end
            it "must create exactly two document reviews with verdict set to 'Approved'" do
                expect(DocumentReview.all.count).to eq(0)
                create(:settlement, :with_processing_payment)
                expect(DocumentReview.all.count).to eq(2)
                expect(DocumentReview.approvals.count).to eq(2)
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
                expect(Settlement.all.count).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(Settlement.all.count).to eq(1)
            end
            it "must create exactly one payment" do
                expect(Payment.all.count).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(Payment.all.count).to eq(1)
            end
            it "must create exactly one law firm" do
                expect(User.law_firms.count).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(User.law_firms.count).to eq(1)
            end
            it "must create exactly one insurance company" do
                expect(User.insurance_companies.count).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(User.insurance_companies.count).to eq(1)
            end
            it "must create exactly one attorney" do
                expect(User.attorneys.count).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(User.attorneys.count).to eq(1)
            end
            it "must create exactly one insurance agent" do
                expect(User.insurance_agents.count).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(User.insurance_agents.count).to eq(1)
            end
            it "must create exactly two stripe accounts" do
                expect(StripeAccount.all.count).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(StripeAccount.all.count).to eq(2)
            end
            it "must create exactly two bank accounts" do
                expect(BankAccount.all.count).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(BankAccount.all.count).to eq(2)
            end
            it "must create exactly one document with status set to 'Approved'" do
                expect(Document.all.count).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(Document.all.count).to eq(1)
                expect(Document.approved.count).to eq(1)
            end
            it "must create exactly two document reviews with verdict set to 'Approved'" do
                expect(DocumentReview.all.count).to eq(0)
                create(:settlement, :with_completed_payment)
                expect(DocumentReview.all.count).to eq(2)
                expect(DocumentReview.approvals.count).to eq(2)
            end
        end
        context "with an active payment request" do
            it "must create a locked settlement" do
                settlement = create(:settlement, :with_unanswered_payment_request)
                expect(settlement.locked?).to be_truthy
            end
            it "must create a payment with a status of 'Not sent'" do
                settlement = create(:settlement, :with_unanswered_payment_request)
                expect(settlement.payments.not_sent.exists?).to be_truthy
            end
            it "must create exactly one settlement" do
                expect(Settlement.all.count).to eq(0)
                create(:settlement, :with_unanswered_payment_request)
                expect(Settlement.all.count).to eq(1)
            end
            it "must create exactly one payment" do
                expect(Payment.all.count).to eq(0)
                create(:settlement, :with_unanswered_payment_request)
                expect(Payment.all.count).to eq(1)
            end
            it "must create exactly one law firm" do
                expect(User.law_firms.count).to eq(0)
                create(:settlement, :with_unanswered_payment_request)
                expect(User.law_firms.count).to eq(1)
            end
            it "must create exactly one insurance company" do
                expect(User.insurance_companies.count).to eq(0)
                create(:settlement, :with_unanswered_payment_request)
                expect(User.insurance_companies.count).to eq(1)
            end
            it "must create exactly one attorney" do
                expect(User.attorneys.count).to eq(0)
                create(:settlement, :with_unanswered_payment_request)
                expect(User.attorneys.count).to eq(1)
            end
            it "must create exactly one insurance agent" do
                expect(User.insurance_agents.count).to eq(0)
                create(:settlement, :with_unanswered_payment_request)
                expect(User.insurance_agents.count).to eq(1)
            end
            it "must create exactly two stripe accounts" do
                expect(StripeAccount.all.count).to eq(0)
                create(:settlement, :with_unanswered_payment_request)
                expect(StripeAccount.all.count).to eq(2)
            end
            it "must create exactly two bank accounts" do
                expect(BankAccount.all.count).to eq(0)
                create(:settlement, :with_unanswered_payment_request)
                expect(BankAccount.all.count).to eq(2)
            end
            it "must create exactly one document with status set to 'Approved'" do
                expect(Document.all.count).to eq(0)
                create(:settlement, :with_unanswered_payment_request)
                expect(Document.all.count).to eq(1)
                expect(Document.approved.count).to eq(1)
            end
            it "must create exactly two document reviews with verdict set to 'Approved'" do
                expect(DocumentReview.all.count).to eq(0)
                create(:settlement, :with_unanswered_payment_request)
                expect(DocumentReview.all.count).to eq(2)
                expect(DocumentReview.approvals.count).to eq(2)
            end
        end
    end
end