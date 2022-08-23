class CreateSettlementLogEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :settlement_log_entries do |t|
      t.references :settlement,   foreign_key: {to_table: :settlements}
      t.references :user,         foreign_key: {to_table: :users}
      t.string :message

      t.timestamps
    end
  end
end
