puts "Beginning DB seed..."

top_100_first_names = ["Michael", "Christopher", "Jessica", "Matthew", "Ashley", "Jennifer", "Joshua", "Amanda", "Daniel", "David", "James", "Robert", "John", "Joseph", "Andrew", "Ryan", "Brandon", "Jason", "Justin", "Sarah", "William", "Jonathan", "Stephanie", "Brian", "Nicole", "Nicholas", "Anthony", "Heather", "Eric", "Elizabeth", "Adam", "Megan", "Melissa", "Kevin", "Steven", "Thomas", "Timothy", "Christina", "Kyle", "Rachel", "Laura", "Lauren", "Amber", "Brittany", "Danielle", "Richard", "Kimberly", "Jeffrey", "Amy", "Crystal", "Michelle", "Tiffany", "Jeremy", "Benjamin", "Mark", "Emily", "Aaron", "Charles", "Rebecca", "Jacob", "Stephen", "Patrick", "Sean", "Erin", "Zachary", "Jamie", "Kelly", "Samantha", "Nathan", "Sara", "Dustin", "Paul", "Angela", "Tyler", "Scott", "Katherine", "Andrea", "Gregory", "Erica", "Mary", "Travis", "Lisa", "Kenneth", "Bryan", "Lindsey", "Kristen", "Jose", "Alexander", "Jesse", "Katie", "Lindsay", "Shannon", "Vanessa", "Courtney", "Christine", "Alicia", "Cody", "Allison", "Bradley", "Samuel"]
top_100_last_names = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzalez", "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin", "Lee", "Perez", "Thompson", "White", "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson", "Walker", "Young", "Allen", "King", "Wright", "Scott", "Torres", "Nguyen", "Hill", "Flores", "Green", "Adams", "Nelson", "Baker", "Hall", "Rivera", "Campbell", "Mitchell", "Carter", "Roberts", "Gomez", "Phillips", "Evans", "Turner", "Diaz", "Parker", "Cruz", "Edwards", "Collins", "Reyes", "Stewart", "Morris", "Morales", "Murphy", "Cook", "Rogers", "Gutierrez", "Ortiz", "Morgan", "Cooper", "Peterson", "Bailey", "Reed", "Kelly", "Howard", "Ramos", "Kim", "Cox", "Ward", "Richardson", "Watson", "Brooks", "Chavez", "Wood", "James", "Bennett", "Gray", "Mendoza", "Ruiz", "Hughes", "Price", "Alvarez", "Castillo", "Sanders", "Patel", "Myers", "Long", "Ross", "Foster", "Jimenez", "Powell"]
# For generating random user names.
insurance_companies = ["State Farm", "Geico", "Progressive", "Allstate", "Liberty Mutual", "USAA", "Nationwide"]
law_firms = ["GKBM", "Morgan & Morgan", "Adams & Reece", "Bass Berry & Sims", "GoodLaw", "Smith & Doe", "Hearsay Law Firm"]
# For generating random organizations to which each user belongs
MEMBERS_PER_ORGANIZATION = 1
SETTLEMENTS_PER_ATTORNEY = 7
DOCUMENTS_PER_SETTLEMENT = 1
# Adjust NUM_USERS_OF_EACH_ROLE to increase/decrease the number of records created when calling the 'rails db:seed' command

law_firm_users = Array.new(1) {|i|
    law_firm = User.new(
        email: "law_firm#{i}@example.com",
        password: "password123",
        role: "Law Firm",
        business_name: law_firms[i],
        #stripe_financial_account_id: "fa_1LUMmBPvLqRcxm3zrV1FlYgb",
        organization: nil
    )
    law_firm.build_stripe_account(
        #stripe_id: "acct_1LUMm4PvLqRcxm3z"
    )
    if law_firm.save
        puts "Created Law Firm i=#{i}: #{law_firm.business_name}"
    else
        raise StandardError.new "⚠️⚠️⚠️ ERROR creating law firm user: #{law_firm.errors.full_messages.inspect}"
    end

    law_firm.bank_accounts.create!(
        stripe_payment_method_id: "FakePaymentId#{rand(0..9999999)}",
        nickname: "STRIPE TEST BANK (Seeded #1)",
        last4: 6789,
        default: true
    )
    law_firm.bank_accounts.create!(
        stripe_payment_method_id: "FakePaymentId#{rand(0..9999999)}",
        nickname: "STRIPE TEST BANK (Seeded #2)",
        last4: 6789,
    )
    law_firm
}

insurance_company_users = Array.new(1) {|i|
    insurance_company = User.new(
        email: "insurance_company#{i}@example.com",
        password: "password123",
        role: "Insurance Company",
        business_name: insurance_companies[i],
        #stripe_financial_account_id: "fa_1LUMmLQ44dejfzxNA7hI1dQb",
        organization: nil
    )
    insurance_company.build_stripe_account(
        #stripe_id: "acct_1LUMmEQ44dejfzxN"
    )
    if insurance_company.save
        puts "Created Insurance Company i=#{i}: #{insurance_company.business_name}"
    else
        raise StandardError.new "⚠️⚠️⚠️ ERROR creating insurance company user: #{insurance_company.errors.full_messages.inspect}"
    end

    insurance_company.bank_accounts.create!(
        stripe_payment_method_id: "FakePaymentId#{rand(0..9999999)}",
        nickname: "STRIPE TEST BANK (Seeded #1)",
        last4: 6789,
        default: true
    )
    insurance_company.bank_accounts.create!(
        stripe_payment_method_id: "FakePaymentId#{rand(0..9999999)}",
        nickname: "STRIPE TEST BANK (Seeded #2)",
        last4: 6789,
    )
    insurance_company
}

attorneys = Array.new(MEMBERS_PER_ORGANIZATION) {|i|
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

insurance_agents = Array.new(MEMBERS_PER_ORGANIZATION) {|i|
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
            amount:      '%.02f' % rand(100000..1999900).fdiv(100),
            defendant_name:     "#{top_100_first_names[rand(0..99)]} #{top_100_last_names[rand(0..99)]}",
            claimant_name:     "#{top_100_first_names[rand(0..99)]} #{top_100_last_names[rand(0..99)]}",
            incident_location:  "Memphis, TN",
            incident_date:      Date.today - rand(30..365).days,
        )
        if !settlement.save
            puts "ERRORS: #{settlement.errors.full_messages.inspect}"
            puts "ERRORS: #{settlement.payments.first.errors.full_messages.inspect}"
            # puts "ERRORS: #{settlement.documents.first.errors.full_messages.inspect}"
        end
        doc = settlement.documents.create!(
            added_by: a,
        )
    end
end

User.all.each do |u|
    u.save
end



puts "Created #{User.all.size} user models..."
puts "======= #{User.all_law_firms.size} law firm models"
puts "======= #{User.all_insurance_companies.size} insurance company models"
puts "======= #{User.all_attorneys.size} attorney models"
puts "======= #{User.all_insurance_agents.size} insurance agent models"
puts "Created #{Settlement.all.size} settlement models..."
puts "Created #{Document.all.size} document models..."

puts "Completed DB seeding!"