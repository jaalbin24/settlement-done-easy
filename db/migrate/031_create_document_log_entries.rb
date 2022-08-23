class CreateDocumentLogEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :document_log_entries do |t|
      t.references :document,   foreign_key: {to_table: :documents}
      t.references :user,       foreign_key: {to_table: :users}
      t.string :message

      t.timestamps
    end
  end
end