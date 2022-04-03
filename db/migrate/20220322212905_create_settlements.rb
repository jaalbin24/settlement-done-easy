class CreateSettlements < ActiveRecord::Migration[6.1]
  def change
    create_table :settlements do |t|
      t.string :claim_number
      t.string :policy_number
      t.float :settlement_amount
      t.string :defendent_name
      t.string :plaintiff_name
      t.string :incident_location
      t.date :incident_date
      t.boolean :signature_requested, null: false, default: false
      t.integer :stage,               null: false, default: 1
      t.integer :status,              null: false, default: 1
      t.string :stripe_product_id
      t.string :stripe_price_id

      t.timestamps
    end
  end
end
