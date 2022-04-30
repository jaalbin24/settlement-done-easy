class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.string :law_firm_name,            null: false, default: "Default Law Firm (FAKE! USED FOR TESTING PURPOSES!)"
      t.string :insurance_company_name,   null: false, default: "Default Insurance Co. (FAKE! USED FOR TESTING PURPOSES!)"
      t.string :claim_number
      t.string :policy_number
      t.string :plaintiff_name
      t.string :defendant_name
      t.string :place_of_incident
      t.string :incident_description
      t.date :date_of_incident
      t.float :settlement_amount,         null: false, default: 0
      t.boolean :approved,                null: false, default: false
      t.boolean :adjustment_needed,       null: false, default: false
      t.boolean :signed,                  null: false, default: false


      t.string :ds_envelope_id

      t.timestamps
    end
  end
end
