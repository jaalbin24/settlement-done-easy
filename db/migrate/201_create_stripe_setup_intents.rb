class CreateStripeSetupIntents < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_setup_intents do |t|
      t.string      :public_id
      t.string      :payment_method_type

      t.references  :payment_method,      foreign_key: {to_table: :payment_methods}
      t.references  :created_by,          foreign_key: {to_table: :users}

      t.string      :stripe_id
      t.string      :stripe_account_id
      t.string      :client_secret
      t.string      :status

      t.timestamps
    end
  end
end
