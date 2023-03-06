class CreateSignatures < ActiveRecord::Migration[6.1]
  def change
    create_table :signatures do |t|
      t.string        :public_id

      t.integer       :corner1_x
      t.integer       :corner1_y
      t.integer       :corner2_x
      t.integer       :corner2_y

      t.string        :signer_email
      t.string        :status

      t.references    :document,    foreign_key: {to_table: :documents}
      t.timestamps
    end
  end
end
