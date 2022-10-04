# == Schema Information
#
# Table name: bank_accounts
#
#  id                       :bigint           not null, primary key
#  default                  :boolean          default(FALSE), not null
#  fingerprint              :string
#  last4                    :integer
#  nickname                 :string
#  status                   :string           default("New"), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  public_id                :string
#  stripe_payment_method_id :string           not null
#  user_id                  :bigint           not null
#
# Indexes
#
#  index_bank_accounts_on_stripe_payment_method_id  (stripe_payment_method_id) UNIQUE
#  index_bank_accounts_on_user_id                   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe "Bank accounts", type: :model do
    before(:each) do
        @bank_accounts = [create(:bank_account_for_insurance_company), create(:bank_account_for_law_firm)]
    end
    it "must have a stripe payment id" do
        @bank_accounts.each do |ba|
            expect(ba.stripe_payment_method_id.blank?).to be_falsey
            expect(ba.valid?).to be_truthy
            ba.stripe_payment_method_id = ""
            expect(ba.valid?).to be_falsey
            ba.reload
            expect(ba.stripe_payment_method_id.blank?).to be_falsey
            expect(ba.valid?).to be_truthy
            ba.stripe_payment_method_id = nil
            expect(ba.valid?).to be_falsey
        end
    end

    context "" do
        it "" do
        
        end
    end
end
