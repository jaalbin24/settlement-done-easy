

unless Rails.env.production?
    require 'english_language'
    include EnglishLanguage
    namespace :stripe_data do
        task :generate, [:num_of_each_organization] => :environment do |task, args|
            if args[:num_of_each_organization].nil?
                num_of_each_organization = 1
            else
                num_of_each_organization = args[:num_of_each_organization].to_i
            end

            organizations = {}
            organizations[:law_firms] = generate_law_firms(num_of_each_organization)
            puts "Registered #{"law firm".pluralize(num_of_each_organization)} with Stripe!"
            organizations[:insurance_companies] = generate_insurance_companies(num_of_each_organization)
            puts "Registered #{"insurance company".pluralize(num_of_each_organization)} with Stripe!"
            write_to_stripe_test_data_file(organizations)
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
                "name"=>cn,
                "phone"=>"7316147141",
                "tax_id"=>"0000000000"
            },
            "owners"=>{
                "sole_owner"=>{
                    "first_name"=>first_name_of_owner,
                    "last_name"=>last_name_of_owner,
                    "email"=>"#{first_name_of_owner.downcase}.#{last_name_of_owner.downcase}@example.com",
                    "id_number"=>"0000000000",
                    "phone"=>"0000000000",
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
                        "director"=>false,
                        "executive"=>true,
                        "owner"=>true,
                        "percent_ownership"=>100,
                        "representative"=>true,
                        "title"=>"Founder"
                    },
                },
            },
            "settings"=>{
                "treasury"=>{
                    "tos_acceptance"=>{
                        "date"=>Time.now.to_i,
                        "ip"=>"127.0.0.1",
                    },
                },
            },
            "tos_acceptance"=>{
                "date"=>Time.now.to_i,
                "ip"=>"127.0.0.1",
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
            },
            settings: {
                treasury: {
                    tos_acceptance: {
                        ip: law_firms_hash[lf]["settings"]["treasury"]["tos_acceptance"]["ip"],
                        date: law_firms_hash[lf]["settings"]["treasury"]["tos_acceptance"]["date"],
                    },
                },
            },
            tos_acceptance: {
                ip: law_firms_hash[lf]["tos_acceptance"]["ip"],
                date: law_firms_hash[lf]["tos_acceptance"]["date"],
            }
        })
        owner = Stripe::Account.create_person(
            account.id,
            {
                first_name: law_firms_hash[lf]["owners"]["sole_owner"]["first_name"],
                last_name: law_firms_hash[lf]["owners"]["sole_owner"]["last_name"],
                email: law_firms_hash[lf]["owners"]["sole_owner"]["email"],
                phone: law_firms_hash[lf]["owners"]["sole_owner"]["phone"],
                id_number: law_firms_hash[lf]["owners"]["sole_owner"]["id_number"],
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
        Stripe::Account.update_person(
            account.id,
            owner.id,
            {
                verification: {
                    document: {
                        front: "file_identity_document_success",
                    },
                },
            },
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
        
        return_value[lf.parameterize.underscore.to_sym] = {
            business_name: lf,
            stripe_id: account.id,
            stripe_financial_account_id: treasury_account.id,
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
                "name"=>cn,
                "phone"=>"7316147141",
                "tax_id"=>"0000000000"
            },
            "owners"=>{
                "sole_owner"=>{
                    "first_name"=>first_name_of_owner,
                    "last_name"=>last_name_of_owner,
                    "email"=>"#{first_name_of_owner.downcase}.#{last_name_of_owner.downcase}@example.com",
                    "id_number"=>"0000000000",
                    "phone"=>"0000000000",
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
                        "director"=>false,
                        "executive"=>true,
                        "owner"=>true,
                        "percent_ownership"=>100,
                        "representative"=>true,
                        "title"=>"Founder"
                    },
                },
            },
            "settings"=>{
                "treasury"=>{
                    "tos_acceptance"=>{
                        "date"=>Time.now.to_i,
                        "ip"=>"127.0.0.1",
                    },
                },
            },
            "tos_acceptance"=>{
                "date"=>Time.now.to_i,
                "ip"=>"127.0.0.1",
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
            },
            settings: {
                treasury: {
                    tos_acceptance: {
                        ip: insurance_companies_hash[ic]["settings"]["treasury"]["tos_acceptance"]["ip"],
                        date: insurance_companies_hash[ic]["settings"]["treasury"]["tos_acceptance"]["date"],
                    },
                },
            },
            tos_acceptance: {
                ip: insurance_companies_hash[ic]["tos_acceptance"]["ip"],
                date: insurance_companies_hash[ic]["tos_acceptance"]["date"],
            }
        })
        owner = Stripe::Account.create_person(
            account.id,
            {
                first_name: insurance_companies_hash[ic]["owners"]["sole_owner"]["first_name"],
                last_name: insurance_companies_hash[ic]["owners"]["sole_owner"]["last_name"],
                email: insurance_companies_hash[ic]["owners"]["sole_owner"]["email"],
                phone: insurance_companies_hash[ic]["owners"]["sole_owner"]["phone"],
                id_number: insurance_companies_hash[ic]["owners"]["sole_owner"]["id_number"],
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
        Stripe::Account.update_person(
            account.id,
            owner.id,
            {
                verification: {
                    document: {
                        front: "file_identity_document_success",
                    },
                },
            },
        )
        treasury_account = Stripe::Treasury::FinancialAccount.create(
            {
                supported_currencies: ['usd'],
                features: {
                    intra_stripe_flows: {requested: true}, # For sending money to LF financial account
                    inbound_transfers: {ach: {requested: true}}, # For transferring from IC bank account to IC financial account
                },
            },
            {stripe_account: account.id},
        )
        return_value[ic.parameterize.underscore.to_sym] = {
            buisness_name: ic,
            stripe_id: account.id,
            stripe_financial_account_id: treasury_account.id,
            external_accounts: {
                bank_account_1_payment_method_id: "",
                bank_account_2_payment_method_id: "",
            },
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
        "#{random_last_name} #{random_last_name} & #{indefinite_articleize(random_animal_name.singularize.capitalize)}"
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
        "Very #{random_adjective.capitalize} Insurance"
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

def write_to_stripe_test_data_file(content)
    Dir.chdir "lib"
    File.delete("stripe_test_data.rb") if File.exist?("stripe_test_data.rb")

    File.open("stripe_test_data.rb", "w+") do |file|
        file.write "# This file is regularly overwritten by the rake task stripe_data:generate.\n"
        file.write "# Do not put anything in this file that you intend to be permanent.\n"
        file.write "module StripeTestData\n"
        file.write "\tdef stripe_test_data_hash\n"
        file.write "\t\t{\n"
        file.write "#{pretty_printed_hash(content, 3)}\n"
        file.write "\t\t}\n"
        file.write "\tend\n"
        file.write "end"
    end

    puts "Wrote hash to lib/stripe_test_data.rb"
end

def pretty_printed_hash(hash, num_tabs=0)
    tabs = "\t" * num_tabs
    return_value = ""
    hash.keys.each do |key|
        if hash[key].is_a?(Hash)
            return_value += "#{tabs}#{key}: {\n"
            return_value += "#{pretty_printed_hash(hash[key], num_tabs + 1)}\n"
            return_value += "#{tabs}}"
        else
            return_value += "#{tabs}#{key}: \"#{hash[key]}\""
        end
        unless hash.keys.last == key
            return_value += ",\n"
        end
    end
    return_value
end