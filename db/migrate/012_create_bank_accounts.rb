class CreateBankAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_accounts do |t|
      t.string      :stripe_id,   null: false
      t.string      :nickname
      t.integer     :last4,       limit: 2 # last4 is a small integer (size: 2 bytes) in the database
      t.string      :fingerprint  # used to track if users have the same bank account connected to SDE
      t.string      :status
      t.boolean     :preferred,   null: false, default: false
      t.references  :user,        null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
