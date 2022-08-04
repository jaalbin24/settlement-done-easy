class CreateStripePaymentIntents < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_payment_intents do |t|
      t.string      :stripe_id,   null: false
      t.references  :settlement,  null: false, foreign_key: {to_table: :settlements}

      t.timestamps
    end
  end
end
