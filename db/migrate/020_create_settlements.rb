class CreateSettlements < ActiveRecord::Migration[6.1]
  def change
    create_table :settlements do |t|
      t.string      :claim_number
      t.string      :policy_number
      t.float       :dollar_amount
      t.string      :defendant_name
      t.string      :plaintiff_name
      t.string      :incident_location
      t.date        :incident_date
      t.integer     :stage,                     null: false, default: 1
      t.integer     :status,                    null: false, default: 1


      t.boolean     :signature_requested,       null: false, default: false
      t.boolean     :payment_made,              null: false, default: false
      t.boolean     :payment_received,          null: false, default: false
      t.boolean     :payment_has_error,         null: false, default: false
      # TODO: These booleans should be converted to methods 

      t.boolean     :completed,                 null: false, default: false

      t.references  :attorney,        foreign_key: {to_table: :users}
      t.references  :insurance_agent, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
