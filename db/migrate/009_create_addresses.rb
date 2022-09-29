class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string      :public_id

      t.string    :line1
      t.string    :line2
      t.string    :city
      t.integer   :postal_code
      t.string    :state
      t.string    :country

      t.timestamps
    end
  end
end
