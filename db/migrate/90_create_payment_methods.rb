class CreatePaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_methods do |t|
      t.string      :public_id

      t.string      :type
      t.string      :stripe_id
      t.integer     :last4,                       limit: 2 # last4 is a small integer (size: 2 bytes) in the database
      t.string      :nickname

      t.references  :user,       foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
