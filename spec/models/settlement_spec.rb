# == Schema Information
#
# Table name: settlements
#
#  id                 :bigint           not null, primary key
#  amount             :float
#  claim_number       :string
#  claimant_name      :string
#  completed          :boolean          default(FALSE), not null
#  incident_date      :date
#  incident_location  :string
#  locked             :boolean          default(FALSE), not null
#  policy_holder_name :string
#  policy_number      :string
#  public_number      :integer
#  ready_for_payment  :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  attorney_id        :bigint
#  insurance_agent_id :bigint
#  log_book_id        :bigint
#  public_id          :string
#  started_by_id      :bigint
#
# Indexes
#
#  index_settlements_on_attorney_id         (attorney_id)
#  index_settlements_on_insurance_agent_id  (insurance_agent_id)
#  index_settlements_on_log_book_id         (log_book_id)
#  index_settlements_on_started_by_id       (started_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (attorney_id => users.id)
#  fk_rails_...  (insurance_agent_id => users.id)
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (started_by_id => users.id)
#
require 'rails_helper'

RSpec.describe "Settlements", type: :model do
    before(:each) do
        @settlement = create(:settlement)
    end
    it "must have an amount" do
        expect(@settlement.valid?).to be_truthy, "Object: #{@settlement.to_json} Error message: #{@settlement.errors.full_messages.inspect}"
        expect(@settlement.amount.blank?).to be_falsey, "Object: #{@settlement.to_json} Error message: #{@settlement.errors.full_messages.inspect}"
        @settlement.amount = nil
        expect(@settlement.valid?).to be_falsey, "Object: #{@settlement.to_json} Error message: #{@settlement.errors.full_messages.inspect}"
    end

    context "without any documents" do
        before(:each) do
            @settlement = create(:settlement)
        end
        it "must not have a processing payment" do
            pending "Implementation"
            fail
        end
        it "must not have a complete payment" do
            pending "Implementation"
            fail
        end
    end

    context "with a processing payment" do
        before(:each) do
            @settlement = create(:settlement, :with_processing_payment)
        end
        it "must be locked" do
            expect(@settlement.valid?).to be_truthy, "Object: #{@settlement.to_json} Error message: #{@settlement.errors.full_messages.inspect}"
            expect(@settlement.locked?).to be_truthy, "Object: #{@settlement.to_json} Error message: #{@settlement.errors.full_messages.inspect}"
            @settlement.locked = false
            expect(@settlement.valid?).to be_falsey, "Object: #{@settlement.to_json} Error message: #{@settlement.errors.full_messages.inspect}"
        end
    end

    context "with a completed payment" do
        before(:each) do
            @settlement = create(:settlement, :with_completed_payment)
        end
        it "must be locked" do
            expect(@settlement.valid?).to be_truthy, "Object: #{@settlement.to_json} Error message: #{@settlement.errors.full_messages.inspect}"
            expect(@settlement.locked?).to be_truthy, "Object: #{@settlement.to_json} Error message: #{@settlement.errors.full_messages.inspect}"
            @settlement.locked = false
            expect(@settlement.valid?).to be_falsey, "Object: #{@settlement.to_json} Error message: #{@settlement.errors.full_messages.inspect}"
        end
    end
end
