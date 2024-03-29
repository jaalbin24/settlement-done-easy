class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.string      :public_id

      t.boolean     :signed
      t.boolean     :needs_signature
      t.boolean     :auto_generated
      t.string      :status,                  null: false, default: "Waiting for review"
      t.string      :nickname

      t.references  :settlement,              foreign_key: {to_table: :settlements}
      t.references  :added_by,                foreign_key: {to_table: :users}

      t.string      :ds_envelope_id

      t.references  :log_book,                foreign_key: {to_table: :log_books}

      t.timestamps
    end
  end
end
