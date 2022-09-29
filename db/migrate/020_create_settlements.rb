class CreateSettlements < ActiveRecord::Migration[6.1]
  def change
    create_table :settlements do |t|
      t.string      :public_id

      t.string      :claim_number
      t.string      :policy_number
      t.float       :amount
      t.string      :defendant_name
      t.string      :claimant_name
      t.string      :incident_location
      t.date        :incident_date
      t.integer     :public_number

      t.boolean     :locked,                    null: false, default: false
      t.boolean     :completed,                 null: false, default: false
      t.boolean     :ready_for_payment,         null: false, default: false

      t.references  :started_by,                foreign_key: {to_table: :users}
      t.references  :attorney,                  foreign_key: {to_table: :users}
      t.references  :insurance_agent,           foreign_key: {to_table: :users}

      t.references  :log_book,                  foreign_key: {to_table: :log_books}

      t.timestamps
    end
  end
end
