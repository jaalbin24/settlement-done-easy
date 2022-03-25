class AddFkColsToComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :release_form, foreign_key: true
    add_reference :comments, :user,         foreign_key: true
  end
end
