class CreateStripeAccountRequirements < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_account_requirements do |t|
      t.string      :public_id

      t.references  :stripe_account,    foreign_key: {to_table: :stripe_accounts}
      t.string      :status
      t.string      :required_item
      

      t.timestamps
    end
  end
end
