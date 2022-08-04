# == Schema Information
#
# Table name: stripe_payment_methods
#
#  id         :bigint           not null, primary key
#  nickname   :string
#  preferred  :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stripe_id  :string           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_stripe_payment_methods_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class StripePaymentMethodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
