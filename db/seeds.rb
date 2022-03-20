puts "Beginning DB seed..."

top_100_first_names = ["Michael", "Christopher", "Jessica", "Matthew", "Ashley", "Jennifer", "Joshua", "Amanda", "Daniel", "David", "James", "Robert", "John", "Joseph", "Andrew", "Ryan", "Brandon", "Jason", "Justin", "Sarah", "William", "Jonathan", "Stephanie", "Brian", "Nicole", "Nicholas", "Anthony", "Heather", "Eric", "Elizabeth", "Adam", "Megan", "Melissa", "Kevin", "Steven", "Thomas", "Timothy", "Christina", "Kyle", "Rachel", "Laura", "Lauren", "Amber", "Brittany", "Danielle", "Richard", "Kimberly", "Jeffrey", "Amy", "Crystal", "Michelle", "Tiffany", "Jeremy", "Benjamin", "Mark", "Emily", "Aaron", "Charles", "Rebecca", "Jacob", "Stephen", "Patrick", "Sean", "Erin", "Zachary", "Jamie", "Kelly", "Samantha", "Nathan", "Sara", "Dustin", "Paul", "Angela", "Tyler", "Scott", "Katherine", "Andrea", "Gregory", "Erica", "Mary", "Travis", "Lisa", "Kenneth", "Bryan", "Lindsey", "Kristen", "Jose", "Alexander", "Jesse", "Katie", "Lindsay", "Shannon", "Vanessa", "Courtney", "Christine", "Alicia", "Cody", "Allison", "Bradley", "Samuel"]
top_100_last_names = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzalez", "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin", "Lee", "Perez", "Thompson", "White", "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson", "Walker", "Young", "Allen", "King", "Wright", "Scott", "Torres", "Nguyen", "Hill", "Flores", "Green", "Adams", "Nelson", "Baker", "Hall", "Rivera", "Campbell", "Mitchell", "Carter", "Roberts", "Gomez", "Phillips", "Evans", "Turner", "Diaz", "Parker", "Cruz", "Edwards", "Collins", "Reyes", "Stewart", "Morris", "Morales", "Murphy", "Cook", "Rogers", "Gutierrez", "Ortiz", "Morgan", "Cooper", "Peterson", "Bailey", "Reed", "Kelly", "Howard", "Ramos", "Kim", "Cox", "Ward", "Richardson", "Watson", "Brooks", "Chavez", "Wood", "James", "Bennett", "Gray", "Mendoza", "Ruiz", "Hughes", "Price", "Alvarez", "Castillo", "Sanders", "Patel", "Myers", "Long", "Ross", "Foster", "Jimenez", "Powell"]
# For generating random user names.

NUM_RECORDS = 4
# Adjust NUM_RECORDS to increase/decrease the number of records created when calling the 'rails db:seed' command
lawyers = Array.new(NUM_RECORDS) {|i|
    User.create!(
        email: "lawyer#{i}@example.com",
        password: 'password123',
        role: "Lawyer",
        first_name: top_100_first_names[rand(0..99)],
        last_name: top_100_last_names[rand(0..99)]
    )
}
puts "Created #{NUM_RECORDS} lawyer models..."

insurance_agents = Array.new(NUM_RECORDS) {|i|
    User.create!(
        email: "insurance_agent#{i}@example.com",
        password: 'password123',
        role: "Insurance Agent",
        first_name: top_100_first_names[rand(0..99)],
        last_name: top_100_last_names[rand(0..99)]
    )
}
puts "Created #{NUM_RECORDS} insurance agent models..."

release_forms = Array.new(NUM_RECORDS) {|i|
    ReleaseForm.create!(
        claim_number:           "#{rand(100000..999999)}",
        policy_number:          "P#{rand(10000..99999)}",
        settlement_amount:      '%.02f' % rand(100000..1000000).fdiv(100),
        lawyer: lawyers[i],
        insurance_agent: insurance_agents[i]
    )
}
puts "Created #{NUM_RECORDS} release form models..."

generated_release_forms = Array.new(NUM_RECORDS) {|i|
    GeneratedReleaseForm.create!(
        claim_number:           "#{rand(100000..999999)}",
        policy_number:          "P#{rand(10000..99999)}",
        settlement_amount:      '%.02f' % rand(100000..1000000).fdiv(100),
        date_of_incident:       "9-10-2021",
        defendant_name:         "Danny Defendant",
        incident_description:   "car accident",
        law_firm_name:          "Saul Goodman & Associates",
        place_of_incident:      "Memphis, TN",
        plaintiff_name:         "Patty Plaintiff",
        lawyer: lawyers[i],
        insurance_agent: insurance_agents[i]
    )
}
puts "Created #{NUM_RECORDS} generated release form models..."

comments = Array.new(NUM_RECORDS) {|i|
    Comment.create!(
        content: "This is blank! What gives??",
        release_form: release_forms[i],
        author: lawyers[i]
    )
    Comment.create!(
        content: "Please fix XYZ and send it back to me! Thanks!",
        release_form: generated_release_forms[i],
        author: lawyers[i]
    )
}
puts "Created #{NUM_RECORDS*2} comment models..."
puts "Completed DB seeding!"