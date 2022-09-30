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

FactoryBot.define do
    factory :bank_account, class: "BankAccount" do
        association :user, factory: [:law_firm, :insurance_company, :attorney, :adjuster]
        sequence(:stripe_payment_method_id) {|i| "pm_FakePaymentMethod-#{i}"}
        status {"New"}
    end
end