# == Schema Information
#
# Table name: payment_methods
#
#  id         :bigint           not null, primary key
#  last4      :integer
#  nickname   :string
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
FactoryBot.define do
  factory :payment_method do
    
  end
end
