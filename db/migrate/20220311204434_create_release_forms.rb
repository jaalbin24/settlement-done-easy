class CreateReleaseForms < ActiveRecord::Migration[6.1]
  def change
    create_table :release_forms do |t|
      t.string :law_firm_name,            null: false, default: "Fake Law Firm"
      t.string :insurance_company_name,   null: false, default: "Fake Insurance Co."
      t.string :claim_number,             null: false, default: "XXXXCLAIMXXXX"
      t.string :policy_number,            null: false, default: "XXXPOLICYXXX"
      t.string :plaintiff_name,           null: false, default: "Peter Pretend Plaintiff"
      t.string :defendant_name,           null: false, default: "David Default Defendant"
      t.string :place_of_incident,        null: false, default: "Gotham City"
      t.string :incident_description,     null: false, default: "an incident"
      t.date :date_of_incident,           null: false, default: "1-1-1900"
      t.float :settlement_amount,         null: false, default: 0

      t.timestamps
    end
  end
end
