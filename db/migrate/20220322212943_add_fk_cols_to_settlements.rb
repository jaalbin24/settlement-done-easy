class AddFkColsToSettlements < ActiveRecord::Migration[6.1]
  def change
    add_reference :settlements, :lawyer,          foreign_key: { to_table: :users }
    add_reference :settlements, :insurance_agent, foreign_key: { to_table: :users }
    # add_reference :settlements, :progress,        foreign_key: true
    # add_reference :settlements, :release_form,    foreign_key: true
  end
end
