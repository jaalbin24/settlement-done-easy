class CreateReleaseForms < ActiveRecord::Migration[6.1]
  def change
    create_table :release_forms do |t|
      t.string :law_firm_name
      t.string :insurance_company_name
      t.string :claim_number
      t.string :policy_number
      t.string :plaintiff_name
      t.string :defendant_name
      t.string :place_of_incident
      t.string :incident_description
      t.date :date_of_incident
      t.float :settlement_amount

      t.timestamps
    end
  end
end
