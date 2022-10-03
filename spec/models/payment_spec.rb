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

Rspec.describe "Payments", type: :model do
    context "that are not sent" do
        it "must not have an inbound transfer id" do
            pending "Needs to be implemented"
            fail
        end

        it "must not have an outbound payment id" do
            pending "Needs to be implemented"
            fail
        end

        it "must not have an outbound transfer id" do
            pending "Needs to be implemented"
            fail
        end
    end
    
    context "that are processing" do
        it "must have an inbound transfer id" do
            pending "Needs to be implemented"
            fail
        end
    end

    context "that are completed" do
        it "must have an inbound transfer id" do
            pending "Needs to be implemented"
            fail
        end

        it "must have an outbound payment id" do
            pending "Needs to be implemented"
            fail
        end

        it "must have an outbound transfer id" do
            pending "Needs to be implemented"
            fail
        end
    end

    context "that are failed" do

    end

    context "that are canceled" do

    end
end