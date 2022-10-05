require 'stripe'
Stripe.api_key = "sk_test_51KvBlgLjpnfKvSk6arxU2hPFxqFyUZ0n04tMySK7zGtaW6uMvyNYSu0hmFFvHWbVfSV5ktCwBpA9SqDURyzLAqB500eojmzBm3"

module StripeTestDataGenerator

    def self.generate_law_firms_hash
        law_firms = {}
        first_names = Array.new(10) do
            random_first_name
        end
        last_names = Array.new(10) do
            random_last_name
        end
        company_names = ["GKBM", "Morgan", "AdamsReece", "BassBerry", "SmithDoe"]
        
        company_names.each do |cn|
            law_firms[cn] = {
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
                        "first_name"=>first_names[1],
                        "last_name"=>last_names[1],
                        "email"=>"#{first_names[1]}.#{last_names[1]}@example.com",
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
                            "executive"=>false,
                            "owner"=>true,
                            "percent_ownership"=>100,
                            "representative"=>false,
                            "title"=>"Founder"
                        },
                    },
                },
            }
        end
        law_firms
    end

    def self.generate_law_firm_stripe_ids
        law_firms_hash = generate_law_firms_hash
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
            #TODO: Make calls to stripe's person api to add the owner.
        end
    end

    def self.generate_insurance_company_stripe_id

    end

    def self.generate_ecosystem

    end

    private

    def self.random_first_name
        top_100_first_names = ["Michael", "Christopher", "Jessica", "Matthew", "Ashley", "Jennifer", "Joshua", "Amanda", "Daniel", "David", "James", "Robert", "John", "Joseph", "Andrew", "Ryan", "Brandon", "Jason", "Justin", "Sarah", "William", "Jonathan", "Stephanie", "Brian", "Nicole", "Nicholas", "Anthony", "Heather", "Eric", "Elizabeth", "Adam", "Megan", "Melissa", "Kevin", "Steven", "Thomas", "Timothy", "Christina", "Kyle", "Rachel", "Laura", "Lauren", "Amber", "Brittany", "Danielle", "Richard", "Kimberly", "Jeffrey", "Amy", "Crystal", "Michelle", "Tiffany", "Jeremy", "Benjamin", "Mark", "Emily", "Aaron", "Charles", "Rebecca", "Jacob", "Stephen", "Patrick", "Sean", "Erin", "Zachary", "Jamie", "Kelly", "Samantha", "Nathan", "Sara", "Dustin", "Paul", "Angela", "Tyler", "Scott", "Katherine", "Andrea", "Gregory", "Erica", "Mary", "Travis", "Lisa", "Kenneth", "Bryan", "Lindsey", "Kristen", "Jose", "Alexander", "Jesse", "Katie", "Lindsay", "Shannon", "Vanessa", "Courtney", "Christine", "Alicia", "Cody", "Allison", "Bradley", "Samuel"]
        top_100_first_names[rand(top_100_first_names.size - 1)]
    end
    
    def self.random_last_name
        top_100_last_names = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzalez", "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin", "Lee", "Perez", "Thompson", "White", "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson", "Walker", "Young", "Allen", "King", "Wright", "Scott", "Torres", "Nguyen", "Hill", "Flores", "Green", "Adams", "Nelson", "Baker", "Hall", "Rivera", "Campbell", "Mitchell", "Carter", "Roberts", "Gomez", "Phillips", "Evans", "Turner", "Diaz", "Parker", "Cruz", "Edwards", "Collins", "Reyes", "Stewart", "Morris", "Morales", "Murphy", "Cook", "Rogers", "Gutierrez", "Ortiz", "Morgan", "Cooper", "Peterson", "Bailey", "Reed", "Kelly", "Howard", "Ramos", "Kim", "Cox", "Ward", "Richardson", "Watson", "Brooks", "Chavez", "Wood", "James", "Bennett", "Gray", "Mendoza", "Ruiz", "Hughes", "Price", "Alvarez", "Castillo", "Sanders", "Patel", "Myers", "Long", "Ross", "Foster", "Jimenez", "Powell"]
        top_100_last_names[rand(top_100_last_names.size - 1)]
    end
end