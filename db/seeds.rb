# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



ReleaseForm.create!(
    claim_number:           "123456789",
    date_of_incident:       "9-10-2021",
    defendant_name:         "Danny Defendant",
    incident_description:   "car accident",
    insurance_company_name: "Geico",
    law_firm_name:          "Saul Goodman & Associates",
    place_of_incident:      "Memphis, TN",
    plaintiff_name:         "Patty Plaintiff",
    policy_number:          "PO12345",
    settlement_amount:      2400.48    
)
