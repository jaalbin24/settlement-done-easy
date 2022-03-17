class AddTypeToReleaseForms < ActiveRecord::Migration[6.1]
  def change
    add_column :release_forms, :type, :string
  end
end
