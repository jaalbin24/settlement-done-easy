class CreateLogBookEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :log_book_entries do |t|
      t.string      :public_id

      t.references  :log_book,    foreign_key: {to_table: :log_books}
      t.references  :user,        foreign_key: {to_table: :users}
      t.string      :message
      t.timestamps
    end
  end
end
