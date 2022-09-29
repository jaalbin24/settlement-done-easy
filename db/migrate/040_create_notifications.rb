class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string      :public_id

      t.references  :user,   foreign_key: {to_table: :users}
      t.string      :title
      t.string      :message
      t.boolean     :seen

      t.timestamps
    end
  end
end
