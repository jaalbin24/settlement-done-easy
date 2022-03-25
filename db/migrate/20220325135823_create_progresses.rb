class CreateProgresses < ActiveRecord::Migration[6.1]
  def change
    create_table :progresses do |t|
      t.integer :stage,           null: false, default: 1
      t.integer :status,          null: false, default: 1
      

      t.timestamps
    end
  end
end
