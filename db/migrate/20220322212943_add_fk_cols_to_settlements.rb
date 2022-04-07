class AddFkColsToSettlements < ActiveRecord::Migration[6.1]
  def change
    add_reference :settlements, :attorney,          foreign_key: { to_table: :users }
    add_reference :settlements, :insurance_agent, foreign_key: { to_table: :users }
  end
end
