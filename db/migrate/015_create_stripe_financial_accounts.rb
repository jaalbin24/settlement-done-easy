class CreateStripeFinancialAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_financial_accounts do |t|
      t.string      :stripe_id

      t.timestamps
    end
  end
end
