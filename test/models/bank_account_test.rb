# == Schema Information
#
# Table name: payment_methods
#
#  id         :bigint           not null, primary key
#  bank_name  :string
#  country    :string
#  currency   :string
#  last4      :integer
#  nickname   :string
#  status     :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  public_id  :string
#  stripe_id  :string
#  user_id    :bigint
#
# Indexes
#
#  index_payment_methods_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
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
