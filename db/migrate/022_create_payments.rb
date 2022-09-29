class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string      :public_id

      t.references  :settlement,                  foreign_key: {to_table: :settlements}
      t.references  :source,                      foreign_key: {to_table: :bank_accounts}
      t.references  :destination,                 foreign_key: {to_table: :bank_accounts}
      t.string      :status,                      null: false,      default: "Not sent"
      t.string      :stripe_inbound_transfer_id
      t.string      :stripe_outbound_payment_id
      t.string      :stripe_outbound_transfer_id
      t.float       :amount,                      null: false
      t.datetime    :completed_at

      t.references  :log_book,                    foreign_key: {to_table: :log_books}

      t.timestamps
    end
    
    add_index :payments, :stripe_inbound_transfer_id,   unique: true
    add_index :payments, :stripe_outbound_payment_id,   unique: true
    add_index :payments, :stripe_outbound_transfer_id,  unique: true
  end
end
