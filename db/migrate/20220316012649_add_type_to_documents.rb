class AddTypeToDocuments < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :type, :string
  end
end
