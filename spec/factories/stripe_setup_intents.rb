# == Schema Information
#
# Table name: stripe_setup_intents
#
#  id                  :bigint           not null, primary key
#  client_secret       :string
#  payment_method_type :string
#  status              :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  created_by_id       :bigint
#  payment_method_id   :bigint
#  public_id           :string
#  stripe_account_id   :string
#  stripe_id           :string
#
# Indexes
#
#  index_stripe_setup_intents_on_created_by_id      (created_by_id)
#  index_stripe_setup_intents_on_payment_method_id  (payment_method_id)
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id)
#  fk_rails_...  (payment_method_id => payment_methods.id)
#
FactoryBot.define do
  factory :stripe_setup_intent do
    
  end
end
