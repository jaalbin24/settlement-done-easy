# == Schema Information
#
# Table name: stripe_accounts
#
#  id                                   :bigint           not null, primary key
#  card_payments_enabled                :boolean
#  transfers_enabled                    :boolean
#  treasury_enabled                     :boolean
#  us_bank_account_ach_payments_enabled :boolean
#  created_at                           :datetime         not null
#  updated_at                           :datetime         not null
#  public_id                            :string
#  stripe_id                            :string
#  user_id                              :bigint
#
# Indexes
#
#  index_stripe_accounts_on_stripe_id  (stripe_id) UNIQUE
#  index_stripe_accounts_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe StripeAccount, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
