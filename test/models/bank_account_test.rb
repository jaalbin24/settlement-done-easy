# == Schema Information
#
# Table name: bank_accounts
#
#  id                       :bigint           not null, primary key
#  default                  :boolean          default(FALSE), not null
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
