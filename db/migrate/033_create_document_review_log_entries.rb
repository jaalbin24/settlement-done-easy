class CreateDocumentReviewLogEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :document_review_log_entries do |t|
      t.references :document_review,    foreign_key: {to_table: :document_reviews}
      t.references :user,               foreign_key: {to_table: :users}
      t.string :message

      t.timestamps
    end
  end
end
