# == Schema Information
#
# Table name: stripe_financial_accounts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stripe_id  :string
#
FactoryBot.define do
  factory :stripe_financial_account do
    string { "" }
  end
end
