# == Schema Information
#
# Table name: bank_accounts
#
#  id          :bigint           not null, primary key
#  fingerprint :string
#  last4       :integer
#  nickname    :string
#  preferred   :boolean          default(FALSE), not null
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  stripe_id   :string           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_bank_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class BankAccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
