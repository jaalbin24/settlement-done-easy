# == Schema Information
#
# Table name: payments
#
#  id                          :bigint           not null, primary key
#  amount                      :float            not null
#  completed_at                :datetime
#  status                      :string           not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  destination_id              :bigint
#  log_book_id                 :bigint
#  public_id                   :string
#  settlement_id               :bigint
#  source_id                   :bigint
#  stripe_inbound_transfer_id  :string
#  stripe_outbound_payment_id  :string
#  stripe_outbound_transfer_id :string
#
# Indexes
#
#  index_payments_on_destination_id               (destination_id)
#  index_payments_on_log_book_id                  (log_book_id)
#  index_payments_on_settlement_id                (settlement_id)
#  index_payments_on_source_id                    (source_id)
#  index_payments_on_stripe_inbound_transfer_id   (stripe_inbound_transfer_id) UNIQUE
#  index_payments_on_stripe_outbound_payment_id   (stripe_outbound_payment_id) UNIQUE
#  index_payments_on_stripe_outbound_transfer_id  (stripe_outbound_transfer_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (destination_id => bank_accounts.id)
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (settlement_id => settlements.id)
#  fk_rails_...  (source_id => bank_accounts.id)
#
require 'rails_helper'

RSpec.describe "Payments", type: :model do
    before(:each) do
        @payment = create(:payment, :from_the_ground_up)
    end
    it "destination bank account must belong to a law firm" do
        expect(@payment.valid?).to be_truthy
        expect(@payment.destination.nil?).to be_falsey
        expect(@payment.destination.user.isLawFirm?).to be_truthy
        @payment.destination.user = create(:insurance_company)
        expect(@payment.valid?).to be_falsey
        expect{@payment.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "must have a source bank account that belongs to an insurance company" do
        expect(@payment.valid?).to be_truthy
        expect(@payment.source.nil?).to be_falsey
        expect(@payment.source.user.isInsuranceCompany?).to be_truthy
        @payment.source.user = create(:law_firm)
        expect(@payment.valid?).to be_falsey
        expect{@payment.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "will automatically adjust their amount to reflect their settlement" do
        expect(@payment.valid?).to be_truthy
        expect(@payment.amount).to eq(@payment.settlement.amount)
        @payment.amount = @payment.settlement.amount + 1
        expect{@payment.save!}.to_not raise_error(ActiveRecord::RecordInvalid)
        expect(@payment.amount).to eq(@payment.settlement.amount)
    end

    it "cannot have their inbound transfer id updated after it is set" do
        expect(@payment.valid?).to be_truthy
        expect(@payment.stripe_inbound_transfer_id.nil?).to be_truthy
        @payment.stripe_inbound_transfer_id = "FakeStripeInboundTransferId"
        @payment.status = "Processing" # <--- Keeps unrelated validation error from being thrown.
        expect{@payment.save!}.to_not raise_error(ActiveRecord::RecordInvalid)
        expect(@payment.stripe_inbound_transfer_id.nil?).to be_falsey
        @payment.stripe_inbound_transfer_id = "AnotherFakeStripeInboundTransferId"
        expect{@payment.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "cannot have their outbound payment id updated after it is set" do
        expect(@payment.valid?).to be_truthy
        expect(@payment.stripe_outbound_payment_id.nil?).to be_truthy
        @payment.stripe_inbound_transfer_id = "FakeStripeInboundTransferId" # <--- Keeps unrelated validation error from being thrown.
        @payment.stripe_outbound_payment_id = "FakeStripeOutboundPaymentId"
        @payment.status = "Processing" # <--- Keeps unrelated validation error from being thrown.
        expect{@payment.save!}.to_not raise_error(ActiveRecord::RecordInvalid)
        expect(@payment.stripe_outbound_payment_id.nil?).to be_falsey
        @payment.stripe_outbound_payment_id = "AnotherFakeStripeOutboundPaymentId"
        expect{@payment.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "cannot have their outbound transfer id updated after it is set" do
        expect(@payment.valid?).to be_truthy
        expect(@payment.stripe_outbound_transfer_id.nil?).to be_truthy
        @payment.stripe_inbound_transfer_id = "FakeStripeInboundTransferId" # <--- Keeps unrelated validation error from being thrown.
        @payment.stripe_outbound_payment_id = "FakeStripeOutboundPaymentId" # <--- Keeps unrelated validation error from being thrown.
        @payment.stripe_outbound_transfer_id = "FakeStripeOutboundTransferId"
        @payment.status = "Complete" # <--- Keeps unrelated validation error from being thrown.
        expect{@payment.save!}.to_not raise_error(ActiveRecord::RecordInvalid)
        expect(@payment.stripe_outbound_transfer_id.nil?).to be_falsey
        @payment.stripe_outbound_transfer_id = "AnotherFakeStripeOutboundTransferId"
        expect{@payment.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end

    context "that are not sent" do
        before(:each) do
            @payment = create(:payment, :from_the_ground_up)
        end
        it "must not have an inbound transfer id" do
            expect(@payment.sent?).to be_falsey
            expect(@payment.valid?).to be_truthy
            expect(@payment.stripe_inbound_transfer_id.blank?).to be_truthy
            @payment.stripe_inbound_transfer_id = "FakeStripeInboundTransferId"
            expect(@payment.valid?).to be_falsey
        end

        it "must not have an outbound payment id" do
            expect(@payment.sent?).to be_falsey
            expect(@payment.valid?).to be_truthy
            expect(@payment.stripe_outbound_payment_id.blank?).to be_truthy
            @payment.stripe_outbound_payment_id = "FakeStripeOutboundPaymentId"
            expect(@payment.valid?).to be_falsey
        end

        it "must not have an outbound transfer id" do
            expect(@payment.sent?).to be_falsey
            expect(@payment.valid?).to be_truthy
            expect(@payment.stripe_outbound_transfer_id.blank?).to be_truthy
            @payment.stripe_outbound_transfer_id = "FakeStripeOutboundTransferId"
            expect(@payment.valid?).to be_falsey
        end
    end
    
    context "that are processing" do
        before(:each) do
            @payment = create(:payment, :processing)
        end
        it "must have an inbound transfer id" do
            expect(@payment.processing?).to be_truthy
            expect(@payment.valid?).to be_truthy
            expect(@payment.stripe_inbound_transfer_id.blank?).to be_falsey
            @payment.stripe_inbound_transfer_id = nil
            expect(@payment.valid?).to be_falsey
            @payment.reload
            expect(@payment.processing?).to be_truthy
            expect(@payment.valid?).to be_truthy
            expect(@payment.stripe_inbound_transfer_id.blank?).to be_falsey
            @payment.stripe_inbound_transfer_id = ""
            expect(@payment.valid?).to be_falsey
        end

        it "must belong to a locked settlement" do
            expect(@payment.processing?).to be_truthy
            expect(@payment.valid?).to be_truthy
            @payment.settlement.save!
            expect(@payment.settlement.locked?).to be_truthy
            @payment.settlement.locked = false
            expect(@payment.settlement.locked?).to be_falsey
            expect(@payment.valid?).to be_falsey
        end
    end

    context "that are completed" do
        before(:each) do
            @payment = create(:payment, :completed)
        end
        it "must have an inbound transfer id" do
            expect(@payment.completed?).to be_truthy
            expect(@payment.valid?).to be_truthy
            expect(@payment.stripe_inbound_transfer_id.blank?).to be_falsey
            @payment.stripe_inbound_transfer_id = nil
            expect(@payment.valid?).to be_falsey
            @payment.reload
            expect(@payment.completed?).to be_truthy
            expect(@payment.valid?).to be_truthy
            expect(@payment.stripe_inbound_transfer_id.blank?).to be_falsey
            @payment.stripe_inbound_transfer_id = ""
            expect(@payment.valid?).to be_falsey
        end

        it "must have an outbound payment id" do
            expect(@payment.completed?).to be_truthy
            expect(@payment.valid?).to be_truthy
            expect(@payment.stripe_outbound_payment_id.blank?).to be_falsey
            @payment.stripe_outbound_payment_id = nil
            expect(@payment.valid?).to be_falsey
            @payment.reload
            expect(@payment.completed?).to be_truthy
            expect(@payment.valid?).to be_truthy
            expect(@payment.stripe_outbound_payment_id.blank?).to be_falsey
            @payment.stripe_outbound_payment_id = ""
            expect(@payment.valid?).to be_falsey
        end

        it "must have an outbound transfer id" do
            expect(@payment.completed?).to be_truthy
            expect(@payment.valid?).to be_truthy
            expect(@payment.stripe_outbound_transfer_id.blank?).to be_falsey
            @payment.stripe_outbound_transfer_id = nil
            expect(@payment.valid?).to be_falsey
            @payment.reload
            expect(@payment.completed?).to be_truthy
            expect(@payment.valid?).to be_truthy
            expect(@payment.stripe_outbound_transfer_id.blank?).to be_falsey
            @payment.stripe_outbound_transfer_id = ""
            expect(@payment.valid?).to be_falsey
        end

        it "must belong to a locked settlement" do
            pending "Needs to be implemented"
            fail
        end
    end

    context "that are failed" do
        before(:each) do
            @payment = create(:payment, :failed)
        end
        it "must have a more recent unsent payment attached to their settlement" do
            pending "Not yet implemented in SDE"
            fail
        end
    end

    context "that are canceled" do
        before(:each) do
            @payment = create(:payment, :canceled)
        end

        it "must have an inbound transfer id" do
            expect(@payment.canceled?).to be_truthy
            expect(@payment.valid?).to be_truthy
            expect(@payment.stripe_inbound_transfer_id.blank?).to be_falsey
            @payment.stripe_inbound_transfer_id = nil
            expect(@payment.valid?).to be_falsey
            @payment.reload
            expect(@payment.canceled?).to be_truthy
            expect(@payment.valid?).to be_truthy
            expect(@payment.stripe_inbound_transfer_id.blank?).to be_falsey
            @payment.stripe_inbound_transfer_id = ""
            expect(@payment.valid?).to be_falsey
        end

        it "must have a more recent unsent payment attached to their settlement" do
            pending "Not yet implemented in SDE"
            fail
        end
    end
end
