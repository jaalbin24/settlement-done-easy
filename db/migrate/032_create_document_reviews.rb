class CreateDocumentReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :document_reviews do |t|
      t.references  :reviewer,    foreign_key: {to_table: :users}
      t.references  :document,    foreign_key: {to_table: :documents}
      t.string      :verdict,     null: false,  default: "Waiting"
      t.string      :reason

      t.references  :log_book,    foreign_key: {to_table: :log_books}

      t.timestamps
    end
  end
end
