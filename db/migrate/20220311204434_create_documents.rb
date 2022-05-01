class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.boolean :approved,                null: false, default: false
      t.boolean :rejected,                null: false, default: false
      t.boolean :signed,                  null: false, default: false
      t.integer :stage

      t.string :ds_envelope_id

      t.timestamps
    end
  end
end
