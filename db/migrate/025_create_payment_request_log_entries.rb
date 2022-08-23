class CreatePaymentRequestLogEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_request_log_entries do |t|
      t.references :payment_request,    foreign_key: {to_table: :payment_requests}
      t.references :user,               foreign_key: {to_table: :users}
      t.string :message

      t.timestamps
    end
  end
end
