puts "Beginning DB seed..."

top_100_first_names = ["Michael", "Christopher", "Jessica", "Matthew", "Ashley", "Jennifer", "Joshua", "Amanda", "Daniel", "David", "James", "Robert", "John", "Joseph", "Andrew", "Ryan", "Brandon", "Jason", "Justin", "Sarah", "William", "Jonathan", "Stephanie", "Brian", "Nicole", "Nicholas", "Anthony", "Heather", "Eric", "Elizabeth", "Adam", "Megan", "Melissa", "Kevin", "Steven", "Thomas", "Timothy", "Christina", "Kyle", "Rachel", "Laura", "Lauren", "Amber", "Brittany", "Danielle", "Richard", "Kimberly", "Jeffrey", "Amy", "Crystal", "Michelle", "Tiffany", "Jeremy", "Benjamin", "Mark", "Emily", "Aaron", "Charles", "Rebecca", "Jacob", "Stephen", "Patrick", "Sean", "Erin", "Zachary", "Jamie", "Kelly", "Samantha", "Nathan", "Sara", "Dustin", "Paul", "Angela", "Tyler", "Scott", "Katherine", "Andrea", "Gregory", "Erica", "Mary", "Travis", "Lisa", "Kenneth", "Bryan", "Lindsey", "Kristen", "Jose", "Alexander", "Jesse", "Katie", "Lindsay", "Shannon", "Vanessa", "Courtney", "Christine", "Alicia", "Cody", "Allison", "Bradley", "Samuel"]
top_100_last_names = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzalez", "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin", "Lee", "Perez", "Thompson", "White", "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson", "Walker", "Young", "Allen", "King", "Wright", "Scott", "Torres", "Nguyen", "Hill", "Flores", "Green", "Adams", "Nelson", "Baker", "Hall", "Rivera", "Campbell", "Mitchell", "Carter", "Roberts", "Gomez", "Phillips", "Evans", "Turner", "Diaz", "Parker", "Cruz", "Edwards", "Collins", "Reyes", "Stewart", "Morris", "Morales", "Murphy", "Cook", "Rogers", "Gutierrez", "Ortiz", "Morgan", "Cooper", "Peterson", "Bailey", "Reed", "Kelly", "Howard", "Ramos", "Kim", "Cox", "Ward", "Richardson", "Watson", "Brooks", "Chavez", "Wood", "James", "Bennett", "Gray", "Mendoza", "Ruiz", "Hughes", "Price", "Alvarez", "Castillo", "Sanders", "Patel", "Myers", "Long", "Ross", "Foster", "Jimenez", "Powell"]
# For generating random user names.
insurance_companies = ["State Farm", "Geico", "Progressive", "Allstate", "Liberty Mutual", "USAA", "Nationwide"]
law_firms = ["GKBM", "Morgan & Morgan", "Adams & Reece", "Bass Berry & Sims", "GoodLaw", "Smith & Doe", "Hearsay Law Firm"]
# For generating random organizations to which each user belongs
SEED_SIZE = 20
NUM_SETTLEMENTS = SEED_SIZE * 1
# Adjust SEED_SIZE to increase/decrease the number of records created when calling the 'rails db:seed' command

docusign_user = User.create!(
    id: 0,
    email: "example@example.com",
    password: "password123",
    first_name: "DocuSign",
    role: "Insurance Company",
)

law_firm_users = Array.new(law_firms.size) {|i|
    law_firm = User.create!(
        email: "law_firm#{i}@example.com",
        password: "password123",
        role: "Law Firm",
        first_name: law_firms[i],
        stripe_account_id: "acct_1KkFqHPrr8Fx4mZy",
        stripe_account_onboarded: true, 
        organization: nil
    )
    puts "======================= Created Law Firm i=#{i}: #{law_firm.first_name}"
    law_firm
}

insurance_company_users = Array.new(insurance_companies.size) {|i|
    insurance_company = User.create!(
        email: "insurance_company#{i}@example.com",
        password: "password123",
        role: "Insurance Company",
        first_name: insurance_companies[i]
    )
    puts "======================= Created Insurance Company i=#{i}: #{insurance_company.first_name}"
    insurance_company
}

shannon_elsea = User.create!(
    email: "shannon.elsea@example.com",
    password: "password123",
    role: "Attorney",
    first_name: "Shannon",
    last_name: "Elsea",
    organization: User.where("first_name=?", :GKBM).first
)

attorneys = Array.new(SEED_SIZE) {|i|
    User.create!(
        email: "attorney#{i}@example.com",
        password: "password123",
        role: "Attorney",
        first_name: top_100_first_names[rand(0..99)],
        last_name: top_100_last_names[rand(0..99)],
        organization: law_firm_users[rand(0..law_firm_users.size-1)],
    )
    puts "======================= Created Attorney i=#{i}"
}
puts "Created #{SEED_SIZE} attorney models..."

insurance_agents = Array.new(SEED_SIZE) {|i|
    User.create!(
        email: "insurance_agent#{i}@example.com",
        password: "password123",
        role: "Insurance Agent",
        first_name: top_100_first_names[rand(0..99)],
        last_name: top_100_last_names[rand(0..99)],
        organization: insurance_company_users[rand(0..insurance_company_users.size-1)],
    )
    puts "======================= Created Insurance Agent i=#{i}"
}
puts "Created #{SEED_SIZE} insurance agent models..."




# settlements = Array.new(1) {|i|
#     attorney = attorneys[rand(0..attorneys.size-1)]
#     insurance_agent = insurance_agents[rand(0..insurance_agents.size-1)]
#     settlement = Settlement.new(
#         attorney:           attorney,
#         insurance_agent:    insurance_agent,
#         claim_number:       "#{rand(100000..999999)}",
#         settlement_amount:  1000.00,
#         defendant_name:     "#{top_100_first_names[rand(0..99)]} #{top_100_last_names[rand(0..99)]}",
#         plaintiff_name:     "#{top_100_first_names[rand(0..99)]} #{top_100_last_names[rand(0..99)]}",
#         incident_location:  "Memphis, TN",
#         incident_date:      Date.today - rand(30..365).days,
#     )
#     settlement.build_document(
#         claim_number:           "#{rand(100000..999999)}",
#         policy_number:          "P#{rand(10000..99999)}",
#         settlement_amount:      '%.02f' % rand(100000..1000000).fdiv(100)
#     )
#     if !settlement.save
#         puts "SAVE FAILED: #{settlement.errors.full_messages.inspect}"
#     end
#     settlement
# }
# puts "Created #{NUM_SETTLEMENTS} settlement models..."

# comments = Array.new(SEED_SIZE) {|i|
#     Comment.create!(
#         content: "This is blank! What gives??",
#         document: documents[i],
#         author: attorneys[i]
#     )
#     Comment.create!(
#         content: "Please fix XYZ and send it back to me! Thanks!",
#         document: generated_documents[i],
#         author: attorneys[i]
#     )
# }
# puts "Created #{SEED_SIZE*2} comment models..."

puts "Completed DB seeding!"