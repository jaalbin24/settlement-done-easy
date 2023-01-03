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
    factory :bank_account, class: "BankAccount", aliases: [:source, :destination] do
        user
        sequence(:stripe_payment_method_id) {|i| "pm_FakePaymentMethod-#{i}"}
        status {"New"}

        after(:create) do |ba|
            puts "🤖🤖🤖 bank_account after(:create) block"
            puts "========> BANK ACCOUNT created!\n"+
                "========> user: #{ba.user.name}\n"+
                "========> # of bank accounts: #{BankAccount.all.size}\n"
        end

        factory :bank_account_for_law_firm do
            association :user, factory: :law_firm
            before(:build) do |ba, e|
                puts "🤖🤖🤖 bank_account_for_law_firm before(:build) block"
                if e.user.nil?
                    ba.user = select_random_law_firm_or_create_one_if_none_exist
                end
            end
        end
        factory :bank_account_for_insurance_company do
            association :user, factory: :insurance_company
            before(:build) do |ba, e|
                puts "🤖🤖🤖 bank_account_for_insurance_company before(:build) block"
                if e.user.nil?
                    ba.user = select_random_insurance_company_or_create_one_if_none_exist
                end
            end
        end
    end
end