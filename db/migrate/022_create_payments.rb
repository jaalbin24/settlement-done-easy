class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string      :public_id

      t.references  :settlement,                  foreign_key: {to_table: :settlements}
      t.string      :status,                      null: false
      t.string      :stripe_inbound_transfer_id
      t.string      :stripe_outbound_payment_id
      t.string      :stripe_outbound_transfer_id
      t.float       :amount,                      null: false
      t.datetime    :completed_at
      t.datetime    :started_at

      t.references  :log_book,                    foreign_key: {to_table: :log_books}

      t.timestamps
    end
    
    add_index :payments, :stripe_inbound_transfer_id,   unique: true
    add_index :payments, :stripe_outbound_payment_id,   unique: true
    add_index :payments, :stripe_outbound_transfer_id,  unique: true
  end
end
