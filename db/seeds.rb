puts "Beginning DB seed..."

top_100_first_names = ["Michael", "Christopher", "Jessica", "Matthew", "Ashley", "Jennifer", "Joshua", "Amanda", "Daniel", "David", "James", "Robert", "John", "Joseph", "Andrew", "Ryan", "Brandon", "Jason", "Justin", "Sarah", "William", "Jonathan", "Stephanie", "Brian", "Nicole", "Nicholas", "Anthony", "Heather", "Eric", "Elizabeth", "Adam", "Megan", "Melissa", "Kevin", "Steven", "Thomas", "Timothy", "Christina", "Kyle", "Rachel", "Laura", "Lauren", "Amber", "Brittany", "Danielle", "Richard", "Kimberly", "Jeffrey", "Amy", "Crystal", "Michelle", "Tiffany", "Jeremy", "Benjamin", "Mark", "Emily", "Aaron", "Charles", "Rebecca", "Jacob", "Stephen", "Patrick", "Sean", "Erin", "Zachary", "Jamie", "Kelly", "Samantha", "Nathan", "Sara", "Dustin", "Paul", "Angela", "Tyler", "Scott", "Katherine", "Andrea", "Gregory", "Erica", "Mary", "Travis", "Lisa", "Kenneth", "Bryan", "Lindsey", "Kristen", "Jose", "Alexander", "Jesse", "Katie", "Lindsay", "Shannon", "Vanessa", "Courtney", "Christine", "Alicia", "Cody", "Allison", "Bradley", "Samuel"]
top_100_last_names = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzalez", "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin", "Lee", "Perez", "Thompson", "White", "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson", "Walker", "Young", "Allen", "King", "Wright", "Scott", "Torres", "Nguyen", "Hill", "Flores", "Green", "Adams", "Nelson", "Baker", "Hall", "Rivera", "Campbell", "Mitchell", "Carter", "Roberts", "Gomez", "Phillips", "Evans", "Turner", "Diaz", "Parker", "Cruz", "Edwards", "Collins", "Reyes", "Stewart", "Morris", "Morales", "Murphy", "Cook", "Rogers", "Gutierrez", "Ortiz", "Morgan", "Cooper", "Peterson", "Bailey", "Reed", "Kelly", "Howard", "Ramos", "Kim", "Cox", "Ward", "Richardson", "Watson", "Brooks", "Chavez", "Wood", "James", "Bennett", "Gray", "Mendoza", "Ruiz", "Hughes", "Price", "Alvarez", "Castillo", "Sanders", "Patel", "Myers", "Long", "Ross", "Foster", "Jimenez", "Powell"]
# For generating random user names.
insurance_companies = ["State Farm", "Geico", "Progressive", "Allstate", "Liberty Mutual", "USAA", "Nationwide"]
law_firms = ["GKBM", "Morgan & Morgan", "Adams & Reece", "Bass Berry & Sims", "GoodLaw", "Smith & Doe", "Hearsay Law Firm"]
# For generating random organizations to which each user belongs
NUM_USERS_OF_EACH_ROLE = 5
SETTLEMENTS_PER_ATTORNEY = 4
DOCUMENTS_PER_SETTLEMENT = 1
# Adjust NUM_USERS_OF_EACH_ROLE to increase/decrease the number of records created when calling the 'rails db:seed' command

docusign_user = User.create!(
    id: 0,
    email: "docusign@example.com",
    password: "password123",
    first_name: "DocuSign",
    last_name: "eSigning",
    role: "Dummy"
)
puts "Created DocuSign user"
doc_generator_user = User.create!(
    email: "doc_generator@example.com",
    password: "password123",
    first_name: "Auto",
    last_name: "Generated",
    role: "Dummy"
)
puts "Created AutoGenerate user"

law_firm_users = Array.new(law_firms.size) {|i|
    law_firm = User.create!(
        email: "law_firm#{i}@example.com",
        password: "password123",
        role: "Law Firm",
        business_name: law_firms[i],
        # stripe_account_id: "acct_1KkFqHPrr8Fx4mZy",
        # stripe_account_onboarded: true, 
        organization: nil
    )
    puts "Created Law Firm i=#{i}: #{law_firm.business_name}"
    law_firm
}

insurance_company_users = Array.new(insurance_companies.size) {|i|
    insurance_company = User.create!(
        email: "insurance_company#{i}@example.com",
        password: "password123",
        role: "Insurance Company",
        business_name: insurance_companies[i]
    )
    puts "Created Insurance Company i=#{i}: #{insurance_company.business_name}"
    insurance_company
}

shannon_elsea = User.create!(
    email: "shannon.elsea@example.com",
    password: "password123",
    role: "Attorney",
    first_name: "Shannon",
    last_name: "Elsea",
    organization: User.where("business_name=?", :GKBM).first
)
puts "Created Shannon Elsea user"

attorneys = Array.new(NUM_USERS_OF_EACH_ROLE) {|i|
    a = User.create!(
        email: "attorney#{i}@example.com",
        password: "password123",
        role: "Attorney",
        first_name: top_100_first_names[rand(0..99)],
        last_name: top_100_last_names[rand(0..99)],
        organization: law_firm_users[rand(0..law_firm_users.size-1)],
    )
    puts "Created Attorney i=#{i}"
    a
}

insurance_agents = Array.new(NUM_USERS_OF_EACH_ROLE) {|i|
    a = User.create!(
        email: "insurance_agent#{i}@example.com",
        password: "password123",
        role: "Insurance Agent",
        first_name: top_100_first_names[rand(0..99)],
        last_name: top_100_last_names[rand(0..99)],
        organization: insurance_company_users[rand(0..insurance_company_users.size-1)],
    )
    puts "Created Insurance Agent i=#{i}"
    a
}

attorneys.each do |a|
    SETTLEMENTS_PER_ATTORNEY.times do |i|
        settlement = Settlement.new(
            attorney:           a,
            insurance_agent:    insurance_agents[rand(0..insurance_agents.size-1)],
            claim_number:       "#{rand(100000..999999)}",
            settlement_amount:  '%.02f' % rand(100000..2499900).fdiv(100),
            defendant_name:     "#{top_100_first_names[rand(0..99)]} #{top_100_last_names[rand(0..99)]}",
            plaintiff_name:     "#{top_100_first_names[rand(0..99)]} #{top_100_last_names[rand(0..99)]}",
            incident_location:  "Memphis, TN",
            incident_date:      Date.today - rand(30..365).days,
        )
        loop do
            doc = settlement.documents.build(
                added_by: a,
                signed: [true, false][rand(0..1)],
                uses_wet_signature: [true, false][rand(0..1)],
                approved: [true, false][rand(0..1)]
            )
            if doc.save
                break
            else
                doc.destroy
            end
        end
        if !settlement.save
            puts "ERRORS: #{settlement.errors.full_messages.inspect}"
        end
    end
end



puts "Created #{User.all.size} user models..."
puts "======= #{User.all_law_firms.size} law firm models"
puts "======= #{User.all_insurance_companies.size} insurance company models"
puts "======= #{User.all_attorneys.size} attorney models"
puts "======= #{User.all_insurance_agents.size} insurance agent models"
puts "Created #{Settlement.all.size} settlement models..."
puts "Created #{Document.all.size} document models..."


# comments = Array.new(NUM_USERS_OF_EACH_ROLE) {|i|
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
# puts "Created #{NUM_USERS_OF_EACH_ROLE*2} comment models..."

puts "Completed DB seeding!"