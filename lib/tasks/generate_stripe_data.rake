

unless Rails.env.production?
    require 'english_language'
    include EnglishLanguage
    namespace :stripe_data do
        task :generate, [:num_of_each_organization] => :environment do |task, args|
            num_of_each_organization = 1 if num_of_each_organization.nil?
            organizations = {}
            organizations[:law_firms] = generate_law_firms(num_of_each_organization)
            puts "Registered #{num_of_each_organization} law firms with Stripe!"
            organizations[:insurance_comapanies] = generate_insurance_companies(num_of_each_organization)
            puts "Registered #{num_of_each_organization} insurance companies with Stripe!"

            puts organizations

        end
    end
end

def generate_law_firms_hash(num_law_firms)
    law_firms_hash = {}
    company_names = Array.new(num_law_firms) do
        generate_random_law_firm_name
    end

    company_names.each do |cn|
        first_name_of_owner = random_first_name
        last_name_of_owner = random_last_name
        law_firms_hash[cn] = {
            "company"=>{
                "address"=>{
                    "city"=>"Memphis",
                    "country"=>"US",
                    "line1"=>"272 South Main Street",
                    "postal_code"=>"38103",
                    "state"=>"TN",
                },
                "name"=>cn.gsub(/_&/, "")[0, 10],
                "phone"=>"7316147141",
                "tax_id"=>"0000000000"
            },
            "owners"=>{
                "sole_owner"=>{
                    "first_name"=>first_name_of_owner,
                    "last_name"=>last_name_of_owner,
                    "email"=>"#{first_name_of_owner}.#{last_name_of_owner}@example.com",
                    "dob"=>{
                        "day"=> rand(1..28),
                        "month"=> rand(1..12),
                        "year"=> rand(1970..1995),
                    },
                    "address"=>{
                        "city"=>"Memphis",
                        "country"=>"US",
                        "line1"=>"272 South Main Street",
                        "postal_code"=>"38103",
                        "state"=>"TN",
                    },
                    "relationship"=>{
                        "director"=>true,
                        "executive"=>true,
                        "owner"=>true,
                        "percent_ownership"=>100,
                        "representative"=>true,
                        "title"=>"Founder"
                    },
                    "id_number"=>"00000000"
                },
            },
        }
    end
    law_firms_hash
end

def generate_law_firms(num_law_firms)
    return_value = {}
    law_firms_hash = generate_law_firms_hash(num_law_firms)
    law_firms_hash.keys.each do |lf|
        account = Stripe::Account.create({
            type: "custom",
            country: "US",
            capabilities: {
                treasury: {requested: true},
                us_bank_account_ach_payments: {requested: true},
                card_payments: {requested: true},
                transfers: {requested: true},
            },
            business_type: "company",
            business_profile: {
                url: "http://settlementdoneeasy.com/",
                mcc: "8111",
                product_description: "Legal services"
            },
            company: {
                address: {
                    city: law_firms_hash[lf]["company"]["address"]["city"],
                    country: law_firms_hash[lf]["company"]["address"]["country"],
                    line1: law_firms_hash[lf]["company"]["address"]["line1"],
                    postal_code: law_firms_hash[lf]["company"]["address"]["postal_code"],
                    state: law_firms_hash[lf]["company"]["address"]["state"]
                },
                name: law_firms_hash[lf]["company"]["name"],
                phone: law_firms_hash[lf]["company"]["phone"],
                tax_id: law_firms_hash[lf]["company"]["tax_id"],
            }
        })
        owner = Stripe::Account.create_person(
            account.id,
            {
                first_name: law_firms_hash[lf]["owners"]["sole_owner"]["first_name"],
                last_name: law_firms_hash[lf]["owners"]["sole_owner"]["last_name"],
                email: law_firms_hash[lf]["owners"]["sole_owner"]["email"],
                dob: {
                    day:  law_firms_hash[lf]["owners"]["sole_owner"]["dob"]["day"],
                    month:  law_firms_hash[lf]["owners"]["sole_owner"]["dob"]["month"],
                    year:  law_firms_hash[lf]["owners"]["sole_owner"]["dob"]["year"],
                },
                address: {
                    city: law_firms_hash[lf]["owners"]["sole_owner"]["address"]["city"],
                    country: law_firms_hash[lf]["owners"]["sole_owner"]["address"]["country"],
                    line1: law_firms_hash[lf]["owners"]["sole_owner"]["address"]["line1"],
                    postal_code: law_firms_hash[lf]["owners"]["sole_owner"]["address"]["postal_code"],
                    state: law_firms_hash[lf]["owners"]["sole_owner"]["address"]["state"],
                },
                relationship: {
                    director: law_firms_hash[lf]["owners"]["sole_owner"]["relationship"]["director"],
                    executive: law_firms_hash[lf]["owners"]["sole_owner"]["relationship"]["executive"],
                    owner: law_firms_hash[lf]["owners"]["sole_owner"]["relationship"]["owner"],
                    percent_ownership: law_firms_hash[lf]["owners"]["sole_owner"]["relationship"]["percent_ownership"],
                    representative: law_firms_hash[lf]["owners"]["sole_owner"]["relationship"]["representative"],
                    title: law_firms_hash[lf]["owners"]["sole_owner"]["relationship"]["title"],
                },
            }
        )
        treasury_account = Stripe::Treasury::FinancialAccount.create(
            {
                supported_currencies: ['usd'],
                features: {
                    intra_stripe_flows: {requested: true}, # For recieving money from IC financial account
                    outbound_transfers: {ach: {requested: true}}, # For transferring from LF financial account to LF bank account
                },
            },
            {stripe_account: account.id},
        )
        # Register the bank accounts w/ Stripe using Capybara.
        Rspec.describe do
            user = create(:law_firm, :with_valid_stripe_data)
            sign_in user
            visit root_path
            click_on "Add account"
            click_on "Agree"
            click_on "Test Institution"
            click_on "Success"
            click_on "Link account"
            click_on "Done"
            click_on "Accept"
            sleep(3)
            visit current_path
            expect(page).to have_text "STRIPE TEST BANK"
        end
        return_value[lf] = {
            stripe_id: account.id,
            financial_account_id: treasury_account.id,
            external_accounts: {
                bank_account_1_payment_method_id: "",
                bank_account_2_payment_method_id: "",
            },
        }
    end
    return_value
end

def generate_insurance_companies_hash(num_insurance_companies)
    insurance_companies_hash = {}
    company_names = Array.new(num_insurance_companies) do
        generate_random_insurance_company_name
    end

    company_names.each do |cn|
        first_name_of_owner = random_first_name
        last_name_of_owner = random_last_name
        insurance_companies_hash[cn] = {
            "company"=>{
                "address"=>{
                    "city"=>"Memphis",
                    "country"=>"US",
                    "line1"=>"272 South Main Street",
                    "postal_code"=>"38103",
                    "state"=>"TN",
                },
                "name"=>cn.gsub(/_&/, "")[0, 10],
                "phone"=>"7316147141",
                "tax_id"=>"0000000000"
            },
            "owners"=>{
                "sole_owner"=>{
                    "first_name"=>first_name_of_owner,
                    "last_name"=>last_name_of_owner,
                    "email"=>"#{first_name_of_owner}.#{last_name_of_owner}@example.com",
                    "dob"=>{
                        "day"=> rand(1..28),
                        "month"=> rand(1..12),
                        "year"=> rand(1970..1995),
                    },
                    "address"=>{
                        "city"=>"Memphis",
                        "country"=>"US",
                        "line1"=>"272 South Main Street",
                        "postal_code"=>"38103",
                        "state"=>"TN",
                    },
                    "relationship"=>{
                        "director"=>true,
                        "executive"=>true,
                        "owner"=>true,
                        "percent_ownership"=>100,
                        "representative"=>true,
                        "title"=>"Founder"
                    },
                    "id_number"=>"00000000"
                },
            },
        }
    end
    insurance_companies_hash
end

def generate_insurance_companies(num_insurance_companies)
    return_value = {}
    insurance_companies_hash = generate_insurance_companies_hash(num_insurance_companies)
    insurance_companies_hash.keys.each do |ic|
        account = Stripe::Account.create({
            type: "custom",
            country: "US",
            capabilities: {
                treasury: {requested: true},
                us_bank_account_ach_payments: {requested: true},
                card_payments: {requested: true},
                transfers: {requested: true},
            },
            business_type: "company",
            business_profile: {
                url: "http://settlementdoneeasy.com/",
                mcc: "6300",
                product_description: "Insurance services"
            },
            company: {
                address: {
                    city: insurance_companies_hash[ic]["company"]["address"]["city"],
                    country: insurance_companies_hash[ic]["company"]["address"]["country"],
                    line1: insurance_companies_hash[ic]["company"]["address"]["line1"],
                    postal_code: insurance_companies_hash[ic]["company"]["address"]["postal_code"],
                    state: insurance_companies_hash[ic]["company"]["address"]["state"]
                },
                name: insurance_companies_hash[ic]["company"]["name"],
                phone: insurance_companies_hash[ic]["company"]["phone"],
                tax_id: insurance_companies_hash[ic]["company"]["tax_id"],
            }
        })
        owner = Stripe::Account.create_person(
            account.id,
            {
                first_name: insurance_companies_hash[ic]["owners"]["sole_owner"]["first_name"],
                last_name: insurance_companies_hash[ic]["owners"]["sole_owner"]["last_name"],
                email: insurance_companies_hash[ic]["owners"]["sole_owner"]["email"],
                dob: {
                    day:  insurance_companies_hash[ic]["owners"]["sole_owner"]["dob"]["day"],
                    month:  insurance_companies_hash[ic]["owners"]["sole_owner"]["dob"]["month"],
                    year:  insurance_companies_hash[ic]["owners"]["sole_owner"]["dob"]["year"],
                },
                address: {
                    city: insurance_companies_hash[ic]["owners"]["sole_owner"]["address"]["city"],
                    country: insurance_companies_hash[ic]["owners"]["sole_owner"]["address"]["country"],
                    line1: insurance_companies_hash[ic]["owners"]["sole_owner"]["address"]["line1"],
                    postal_code: insurance_companies_hash[ic]["owners"]["sole_owner"]["address"]["postal_code"],
                    state: insurance_companies_hash[ic]["owners"]["sole_owner"]["address"]["state"],
                },
                relationship: {
                    director: insurance_companies_hash[ic]["owners"]["sole_owner"]["relationship"]["director"],
                    executive: insurance_companies_hash[ic]["owners"]["sole_owner"]["relationship"]["executive"],
                    owner: insurance_companies_hash[ic]["owners"]["sole_owner"]["relationship"]["owner"],
                    percent_ownership: insurance_companies_hash[ic]["owners"]["sole_owner"]["relationship"]["percent_ownership"],
                    representative: insurance_companies_hash[ic]["owners"]["sole_owner"]["relationship"]["representative"],
                    title: insurance_companies_hash[ic]["owners"]["sole_owner"]["relationship"]["title"],
                },
            }
        )
        return_value[ic] = {
            stripe_id: account.id,
        }
    end
    return_value
end

def generate_random_law_firm_name
    random_number = rand(1..10)
    case random_number
    when 1, 2, 3, 4, 5
        "#{random_last_name} & #{random_last_name}"
    when 6, 7
        "#{random_last_name} #{random_last_name} & #{random_last_name}"
    when 8
        "#{random_adjective.capitalize} Law"
    when 9
        "Law #{random_noun.pluralize.capitalize}"
    when 10
        "#{random_last_name} #{random_last_name} & #{random_animal_name.singularize.capitalize.indefinite_articleize(word)}"
    else
        raise StandardError.new "Something broke your algorithm. The random number is not between 1 and 10."
    end
end

def generate_random_insurance_company_name
    random_number = rand(1..10)
    case random_number
    when 1, 2, 3, 4, 5
        "#{random_adjective.capitalize} Insurance"
    when 6, 7
        "#Very #{random_adjective.capitalize} Insurance"
    when 8
        "Insurance #{random_noun.pluralize.capitalize}"
    when 9
        "Insura#{random_noun.capitalize}"
    when 10
        "Insurance for #{random_animal_name.pluralize.capitalize}"
    else
        raise StandardError.new "Something broke your algorithm. The random number is not between 1 and 10."
    end
end