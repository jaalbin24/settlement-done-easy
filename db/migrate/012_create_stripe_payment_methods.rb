class CreateStripePaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_payment_methods do |t|
      t.string      :stripe_id,   null: false
      t.string      :nickname
      t.boolean     :preferred,   null: false, default: false
      t.references  :user,        null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
