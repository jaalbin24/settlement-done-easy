class CreatePaymentLogEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_log_entries do |t|
      t.references :payment,    foreign_key: {to_table: :payments}
      t.references :user,       foreign_key: {to_table: :users}
      t.string :message

      t.timestamps
    end
  end
end
