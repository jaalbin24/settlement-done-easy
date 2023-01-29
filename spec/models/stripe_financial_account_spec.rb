# == Schema Information
#
# Table name: stripe_financial_accounts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stripe_id  :string
#
require 'rails_helper'

RSpec.describe StripeFinancialAccount, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
