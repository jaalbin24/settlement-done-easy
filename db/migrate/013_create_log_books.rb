class CreateLogBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :log_books do |t|
      t.timestamps
    end
  end
end
