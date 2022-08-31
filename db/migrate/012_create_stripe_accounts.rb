class CreateStripeAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_accounts do |t|
      t.string      :stripe_id
      t.references  :user,   foreign_key: {to_table: :users}

      t.boolean     :card_payments_enabled
      t.boolean     :transfers_enabled
      t.boolean     :us_bank_account_ach_payments_enabled
      t.boolean     :treasury_enabled

      t.timestamps
    end

    add_index :stripe_accounts,   :stripe_id,   unique: true
  end
end
