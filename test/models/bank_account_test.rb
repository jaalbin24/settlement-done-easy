# == Schema Information
#
# Table name: payment_methods
#
#  id          :bigint           not null, primary key
#  bank_name   :string
#  country     :string
#  currency    :string
#  default     :boolean
#  exp_month   :integer
#  exp_year    :integer
#  last4       :integer
#  nickname    :string
#  status      :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  added_by_id :bigint
#  address_id  :bigint
#  public_id   :string
#  stripe_id   :string
#
# Indexes
#
#  index_payment_methods_on_added_by_id  (added_by_id)
#  index_payment_methods_on_address_id   (address_id)
#
# Foreign Keys
#
#  fk_rails_...  (added_by_id => users.id)
#  fk_rails_...  (address_id => addresses.id)
#
require "test_helper"

class BankAccountTest < ActiveSupport::TestCase

    test "fixtures are valid" do
        assert !bank_accounts.empty?, "There are no bank account fixtures to test!"
        bank_accounts.each do |ba|
            assert ba.valid?, ba.errors.full_messages.inspect
        end
    end


    test "bank account cannot be deleted while it has ongoing payments" do

    end
end
