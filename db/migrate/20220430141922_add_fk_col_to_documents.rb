class AddFkColToDocuments < ActiveRecord::Migration[6.1]
  def change
    add_reference :documents, :settlement,  foreign_key: {to_table: :settlements}
    add_reference :documents, :added_by,    foreign_key: {to_table: :users}
  end
end
