class CreatePaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_methods do |t|
      t.string      :public_id
      t.string      :type
      t.boolean     :default
      t.string      :stripe_id 
      # ba_ for bank accounts
      # card_ for debit cards

      t.integer     :last4,                       limit: 2 # last4 is a small integer (size: 2 bytes) in the database
      t.string      :nickname
      t.string      :bank_name
      t.string      :country
      t.string      :currency
      t.string      :status

      t.integer     :exp_month
      t.integer     :exp_year

      t.references  :added_by,    foreign_key: {to_table: :users}
      t.references  :address,     foreign_key: {to_table: :addresses}

      t.timestamps
    end
  end
end
