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

RSpec.describe BankAccount, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
