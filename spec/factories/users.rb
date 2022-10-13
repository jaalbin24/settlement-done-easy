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


require "english_language"
require "stripe_test_data"
include EnglishLanguage
include StripeTestData

FactoryBot.define do
    # The user factory exists as an abstract factory. It is not meant to be used to create fixtures. 
    # It is meant to be inherited by the other user types. Running 'create(:user)' will throw validation errors because a generic
    # user with no role (ie, attorney, adjuster) will never exist in this application.
    factory :user, class: "User", aliases: [:added_by, :reviewer] do
        password {"password123"}
        sequence(:email) { |i| "user.#{i}@example.com" }
        transient do
            num_members {1}
            num_bank_accounts {1}
            num_settlements {0}
            stripe_id {}
        end
        after(:create) do |u|
            puts "🤖🤖🤖 user after(:create) block"
            puts "========> #{u.full_name} created!\n"+
                "========> Members: #{u.members.size}\n"+
                "========> BankAccounts: #{u.bank_accounts.size}\n"+
                "========> settlements: #{u.settlements.size}\n"+
                "========> settings.blank?: #{u.settings.blank?}\n"+
                "========> settings.to_json: #{u.settings.to_json}\n"+
                "========> # of law firms: #{User.law_firms.size}\n"+
                "========> # of insurance companies: #{User.insurance_companies.size}\n"+
                "========> # of attorneys: #{User.attorneys.size}\n"+
                "========> # of adjusters: #{User.insurance_agents.size}\n"
        end

        trait :not_activated do
            transient do
                num_bank_accounts {0}
                num_settlements {0}
            end
        end

        factory :law_firm do
            role {"Law Firm"}
            business_name {random_law_firm_name}
            after(:build) do |u, e|
                puts "🤖🤖🤖 law_firm after(:build) block"
                u.stripe_account = build(:stripe_account, user: u) if u.stripe_account.nil?
            end
            after(:create) do |u, e|
                puts "🤖🤖🤖 law_firm after(:create) block"
                u.bank_accounts = create_list(:bank_account_for_law_firm, e.num_bank_accounts, user: u)  if u.bank_accounts.empty? && e.num_bank_accounts > 0
                u.members = create_list(:attorney, e.num_members, organization: u)                       if u.members.empty? && e.num_members > 0
                u.touch
            end

            transient do
                stripe_id {}
            end
            stripe_financial_account_id {}
            after(:build) do |u, e|
                puts "🤖🤖🤖 law_firm after(:build) block"
                # This block finds a stripe-id-pair that is not being used. This avoids db-unique-constraint-conflict errors
                # as long as the number of law firm users in the database is less than the number of stripe-id-pairs generated by
                # the stripe_data:generate rake task.
                stripe_test_data_hash[:law_firms].keys.each do |key|
                    financial_account_id_being_tested = stripe_test_data_hash[:law_firms][key][:stripe_financial_account_id]

                    unless User.where(stripe_financial_account_id: financial_account_id_being_tested).exists?
                        u.stripe_financial_account_id = financial_account_id_being_tested
                        u.stripe_account = build(:stripe_account, user: u, stripe_id: stripe_test_data_hash[:law_firms][key][:stripe_id])
                        break
                    end
                    if key == stripe_test_data_hash[:law_firms].keys.last
                        raise StandardError.new "There are not enough law firms in the stripe test data hash to accomodate the test load.\nUser.count=#{User.count}\nUser.law_firms.count=#{User.law_firms.count}"
                    end
                end
            end
        end

        factory :insurance_company do
            role {"Insurance Company"}
            business_name {random_insurance_company_name}
            after(:create) do |u, e|
                puts "🤖🤖🤖 insurance_company after(:create) block"
                u.bank_accounts = create_list(:bank_account_for_insurance_company, e.num_bank_accounts, user: u) if u.bank_accounts.empty? && e.num_bank_accounts > 0
                u.members = create_list(:adjuster, e.num_members, organization: u)                               if u.members.empty? && e.num_members > 0
                u.touch
            end

            transient do
                stripe_id {stripe_test_data_hash[:insurance_companies][stripe_test_data_hash[:insurance_companies].keys.first][:stripe_id]}
            end
            stripe_financial_account_id {stripe_test_data_hash[:insurance_companies][stripe_test_data_hash[:insurance_companies].keys.first][:stripe_financial_account_id]}
            after(:build) do |u, e|
                puts "🤖🤖🤖 insurance_company after(:build) block"
                # This block finds a stripe-id-pair that is not being used. This avoids db-unique-constraint-conflict errors
                # as long as the number of insurance company users in the database is less than the number of stripe-id-pairs generated by
                # the stripe_data:generate rake task.
                stripe_test_data_hash[:insurance_companies].keys.each do |key|
                    financial_account_id_being_tested = stripe_test_data_hash[:insurance_companies][key][:stripe_financial_account_id]

                    unless User.where(stripe_financial_account_id: financial_account_id_being_tested).exists?
                        u.stripe_financial_account_id = financial_account_id_being_tested
                        u.stripe_account = build(:stripe_account, user: u, stripe_id: stripe_test_data_hash[:insurance_companies][key][:stripe_id])
                        break
                    end
                    if key == stripe_test_data_hash[:insurance_companies].keys.last
                        raise StandardError.new "There are not enough insurance companies in the stripe test data hash to accomodate the test load.\nUser.count=#{User.count}\nUser.insurance_companies.count=#{User.insurance_companies.count}"
                    end
                end
                # raise StandardError.new "Stripe Id is blank" if u.stripe_account.stripe_id.blank?
                # raise StandardError.new "Financial Account Id is blank" if u.stripe_financial_account_id.blank?
            end
            # before(:create) do |u, e|
            #     raise StandardError.new "Stripe Id is blank" if u.stripe_account.stripe_id.blank?
            #     raise StandardError.new "Financial Account Id is blank" if u.stripe_financial_account_id.blank?
            # end
        end
        
        factory :attorney do
            role {"Attorney"}
            first_name {random_first_name}
            last_name {random_last_name}
            trait :with_unactivated_organization do
                transient do
                    num_settlements {0}
                end
                association :organization, :not_activated, factory: :law_firm, num_members: 0
            end
            association :organization, factory: :law_firm, num_members: 0
            after(:create) do |u, e|
                puts "🤖🤖🤖 attorney after(:create) block"
                if u.settlements.empty? && e.num_settlements > 0
                    u.a_settlements = create_list(:settlement, e.num_settlements, attorney: u, insurance_agent: select_random_insurance_agent_or_create_one_if_none_exist)
                end
                u.organization.save
            end
        end

        factory :adjuster, aliases: [:insurance_agent] do # TODO: When the big switch from 'I.n.s.u.r.a.n.c.e A.g.e.n.t' to 'Adjuster' happens, you should be able to remove the alias.
            role {"Insurance Agent"}
            first_name {random_first_name}
            last_name {random_last_name}
            trait :with_unactivated_organization do
                transient do
                    num_settlements {0}
                end
                association :organization, :not_activated, factory: :insurance_company, num_members: 0
            end
            association :organization, factory: :insurance_company, num_members: 0
            after(:create) do |u, e|
                puts "🤖🤖🤖 adjuster after(:create) block"
                if u.settlements.empty? && e.num_settlements > 0
                    u.ia_settlements = create_list(:settlement, e.num_settlements, attorney: select_random_attorney_or_create_one_if_none_exist, insurance_agent: u)
                end
                u.organization.save
            end
        end
    end
end

def select_random_insurance_agent_or_create_one_if_none_exist
    count = User.insurance_companies.activated.count
    if count == 0
        adjuster = create(:insurance_agent)
        adjuster
    else
        random_offset = rand(count)
        random_activated_insurance__company = User.insurance_companies.activated.offset(random_offset).first
        random_adjuster = random_activated_insurance__company.members.sample
        random_adjuster
    end
end

def select_random_attorney_or_create_one_if_none_exist
    count = User.law_firms.activated.count
    if count == 0
        attorney = create(:attorney)
        attorney
    else
        random_offset = rand(count)
        random_activated_law_firm = User.law_firms.activated.offset(random_offset).first
        random_attorney = random_activated_law_firm.members.sample
        random_attorney
    end
end

def select_random_law_firm_or_create_one_if_none_exist
    count = User.law_firms.activated.count
    if count == 0
        law_firm = create(:law_firm)
        law_firm
    else
        random_offset = rand(count)
        random_activated_law_firm = User.law_firms.activated.offset(random_offset).first
        random_activated_law_firm
    end
end

def select_random_insurance_company_or_create_one_if_none_exist
    count = User.insurance_company.activated.count
    if count == 0
        insurance_company = create(:insurance_company)
        insurance_company
    else
        random_offset = rand(count)
        random_activated_insurance_company = User.insurance_companies.activated.offset(random_offset).first
        random_activated_insurance_company
    end
end

def random_attorney
    count = User.where(role: "Attorney").count
    raise StandardError.new "Cannot select a random attorney because there are no attorneys." if count == 0
    random_offset = rand(count)
    random_attorney = User.where(role: "Attorney").offset(random_offset).first
    random_attorney
end

def random_adjuster
    count = User.where(role: "Insurance Agent").count
    raise StandardError.new "Cannot select a random adjuster because there are no adjusters." if count == 0
    random_offset = rand(count)
    random_insurance_agent = User.where(role: "Insurance Agent").offset(random_offset).first
    random_insurance_agent
end

def random_law_firm_name
    law_firm_stripe_ids.keys.sample
end

def random_insurance_company_name
    insurance_company_stripe_ids.keys.sample
end

def law_firm_stripe_ids
    {"GKBM"=>"", "Morgan & Morgan"=>"", "Adams & Reece"=>"", "Bass Berry & Sims"=>"", "Smith & Doe"=>""}
end

def insurance_company_stripe_ids
    {"State Farm"=>"", "Geico"=>"", "Progressive"=>"", "Allstate"=>"", "Liberty Mutual"=>""}
end