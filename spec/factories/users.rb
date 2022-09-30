# == Schema Information
#
# Table name: users
#
#  id                          :bigint           not null, primary key
#  activated                   :boolean          default(FALSE), not null
#  business_name               :string
#  current_sign_in_at          :datetime
#  current_sign_in_ip          :string
#  email                       :string           default(""), not null
#  encrypted_password          :string           default(""), not null
#  first_name                  :string
#  last_name                   :string
#  last_sign_in_at             :datetime
#  last_sign_in_ip             :string
#  remember_created_at         :datetime
#  reset_password_sent_at      :datetime
#  reset_password_token        :string
#  role                        :string
#  sign_in_count               :integer          default(0), not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  organization_id             :bigint
#  public_id                   :string
#  stripe_financial_account_id :string
#
# Indexes
#
#  index_users_on_email                        (email) UNIQUE
#  index_users_on_organization_id              (organization_id)
#  index_users_on_reset_password_token         (reset_password_token) UNIQUE
#  index_users_on_stripe_financial_account_id  (stripe_financial_account_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => users.id)
#

FactoryBot.define do
    factory :user, class: "User" do # Will fail validation. Do not create.
        password {"password123"}
        sequence(:email) { |i| "user.#{i}@example.com" }
        transient do
            num_members {0}
        end

        factory :law_firm do
            role {"Law Firm"}
            business_name {"GKBM"}
            sequence(:stripe_financial_account_id) {|i| "fa_1LUMmBPvLqRcxm3zrV1FlYgb-#{i}"}
            members do
                Array.new(num_members) {association(:members, factory: :attorney)}
            end
            after(:build) do |u|
                u.stripe_account = build(:stripe_account, user: u)
            end
            after(:create) do |u|
                create_list(:bank_account, 2, user: u)
            end
        end

        factory :insurance_company do
            role {"Insurance Company"}
            business_name {"State Farm"}
            sequence(:stripe_financial_account_id) {|i| "fa_1LUMmLQ44dejfzxNA7hI1dQb-#{i}"}
            members do
                Array.new(num_members) {association(:members, factory: :adjuster)}
            end
            after(:build) do |u|
                u.stripe_account = build(:stripe_account, user: u)
            end
            after(:create) do |u|
                create_list(:bank_account, 2, user: u)
            end
        end

        factory :attorney do
            role {"Attorney"}
            first_name {"Lilly"}
            last_name {"Lawyer"}
            # association :organization, factory: :law_firm
        end

        factory :adjuster do
            role {"Insurance Agent"}
            first_name {"Adam"}
            last_name {"Adjuster"}
            # association :organization, factory: :insurance_company
        end
    end
end

def create_one_user_of_each_role
    
end