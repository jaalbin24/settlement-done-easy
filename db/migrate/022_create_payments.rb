class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.references  :settlement,  foreign_key: {to_table: :settlements}
      t.references  :source,      foreign_key: {to_table: :bank_accounts}
      t.references  :destination, foreign_key: {to_table: :bank_accounts}
      t.string      :stripe_inbound_transfer_id
      t.string      :stripe_outbound_payment_id
      t.string      :stripe_outbound_transfer_id
      t.float       :amount,      null: false
      t.timestamps
    end
  end
end
