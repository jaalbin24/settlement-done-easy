class AddFkColsToProgresses < ActiveRecord::Migration[6.1]
  def change
    add_reference :progresses, :settlement, foreign_key: true
  end
end
