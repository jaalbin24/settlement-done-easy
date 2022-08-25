class CreatePaymentRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_requests do |t|
      t.references  :requester,   foreign_key: {to_table: :users}
      t.references  :accepter,    foreign_key: {to_table: :users}
      t.references  :settlement,  foreign_key: {to_table: :settlements}
      t.string      :status,      null: false,  default: "Requested"

      t.references  :log_book,    foreign_key: {to_table: :log_books}

      t.timestamps
    end
  end
end
