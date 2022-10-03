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
    # The user factory exists as an abstract factory. It is not meant to be used to create fixtures. 
    # It is meant to be inherited by the other user types. Running 'create(:user)' will throw validation errors because a generic
    # user with no role (ie, attorney, adjuster) will never exist in this application.
    factory :user, class: "User", aliases: [:added_by] do
        password {"password123"}
        sequence(:email) { |i| "user.#{i}@example.com" }
        transient do
            num_members {1}
            num_bank_accounts {1}
            num_settlements {1}
        end
        after(:create) do |u|
            puts "========> #{u.full_name} created!\n"+
                "========> Members: #{u.members.size}\n"+
                "========> BankAccounts: #{u.bank_accounts.size}\n"+
                "========> settlements: #{u.settlements.size}\n"+
                "========> settings.blank?: #{u.settings.blank?}\n"+
                "========> settings.to_json: #{u.settings.to_json}\n"
        end

        trait :not_activated do
            transient do
                num_members {1}
                num_bank_accounts {0}
                num_settlements {0}
            end
        end

        factory :law_firm do
            role {"Law Firm"}
            business_name {"GKBM"}
            sequence(:stripe_financial_account_id) {|i| "fa_1LUMmBPvLqRcxm3zrV1FlYgb-#{i}"}
            after(:build) do |u, e|
                u.stripe_account = build(:stripe_account, user: u)
                u.bank_accounts = build_list(:bank_account, e.num_bank_accounts, user: u)
                u.members = build_list(:attorney, e.num_members, organization: u)
            end
        end

        factory :insurance_company do
            role {"Insurance Company"}
            business_name {"State Farm"}
            sequence(:stripe_financial_account_id) {|i| "fa_1LUMmLQ44dejfzxNA7hI1dQb-#{i}"}
            after(:build) do |u, e|
                u.stripe_account = build(:stripe_account, user: u)
                u.bank_accounts = build_list(:bank_account, e.num_bank_accounts, user: u)
                u.members = build_list(:adjuster, e.num_members, organization: u)
            end
        end

        

        factory :attorney do
            role {"Attorney"}
            first_name {random_first_name}
            last_name {random_last_name}
            trait :with_unactivated_organization do
                transient do
                    num_settlements {0}
                end
                after(:build) do |u, e|
                    u.organization = build(:law_firm, :not_activated)
                end
            end
            association :organization, factory: :law_firm
            after(:create) do |u, e|
                u.a_settlements = create_list(:settlement, e.num_settlements, attorney: u, insurance_agent: select_random_insurance_agent_or_create_one_if_none_exist)
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
                after(:build) do |u, e|
                    u.organization = build(:insurance_company, :not_activated)
                end
            end
            association :organization, factory: :insurance_company
            after(:create) do |u, e|
                if u.settlements.empty?
                    u.ia_settlements = create_list(:settlement, e.num_settlements, insurance_agent: u, attorney: select_random_attorney_or_create_one_if_none_exist)
                end
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

def random_first_name
    top_100_first_names = ["Michael", "Christopher", "Jessica", "Matthew", "Ashley", "Jennifer", "Joshua", "Amanda", "Daniel", "David", "James", "Robert", "John", "Joseph", "Andrew", "Ryan", "Brandon", "Jason", "Justin", "Sarah", "William", "Jonathan", "Stephanie", "Brian", "Nicole", "Nicholas", "Anthony", "Heather", "Eric", "Elizabeth", "Adam", "Megan", "Melissa", "Kevin", "Steven", "Thomas", "Timothy", "Christina", "Kyle", "Rachel", "Laura", "Lauren", "Amber", "Brittany", "Danielle", "Richard", "Kimberly", "Jeffrey", "Amy", "Crystal", "Michelle", "Tiffany", "Jeremy", "Benjamin", "Mark", "Emily", "Aaron", "Charles", "Rebecca", "Jacob", "Stephen", "Patrick", "Sean", "Erin", "Zachary", "Jamie", "Kelly", "Samantha", "Nathan", "Sara", "Dustin", "Paul", "Angela", "Tyler", "Scott", "Katherine", "Andrea", "Gregory", "Erica", "Mary", "Travis", "Lisa", "Kenneth", "Bryan", "Lindsey", "Kristen", "Jose", "Alexander", "Jesse", "Katie", "Lindsay", "Shannon", "Vanessa", "Courtney", "Christine", "Alicia", "Cody", "Allison", "Bradley", "Samuel"]
    top_100_first_names[rand(top_100_first_names.size - 1)]
end

def random_last_name
    top_100_last_names = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzalez", "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin", "Lee", "Perez", "Thompson", "White", "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson", "Walker", "Young", "Allen", "King", "Wright", "Scott", "Torres", "Nguyen", "Hill", "Flores", "Green", "Adams", "Nelson", "Baker", "Hall", "Rivera", "Campbell", "Mitchell", "Carter", "Roberts", "Gomez", "Phillips", "Evans", "Turner", "Diaz", "Parker", "Cruz", "Edwards", "Collins", "Reyes", "Stewart", "Morris", "Morales", "Murphy", "Cook", "Rogers", "Gutierrez", "Ortiz", "Morgan", "Cooper", "Peterson", "Bailey", "Reed", "Kelly", "Howard", "Ramos", "Kim", "Cox", "Ward", "Richardson", "Watson", "Brooks", "Chavez", "Wood", "James", "Bennett", "Gray", "Mendoza", "Ruiz", "Hughes", "Price", "Alvarez", "Castillo", "Sanders", "Patel", "Myers", "Long", "Ross", "Foster", "Jimenez", "Powell"]
    top_100_last_names[rand(top_100_last_names.size - 1)]
end