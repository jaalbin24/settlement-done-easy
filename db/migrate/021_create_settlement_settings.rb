class CreateSettlementSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :settlement_settings do |t|
      t.string      :public_id

      t.references  :user,        foreign_key: {to_table: :users}
      t.references  :settlement,  foreign_key: {to_table: :settlements}

      t.boolean     :replace_unsigned_document_with_signed_document
      t.boolean     :alert_when_settlement_ready_for_payment
      t.boolean     :alert_when_payment_requested
      t.boolean     :confirmation_before_document_rejection
      t.boolean     :delete_my_documents_after_rejection
      t.boolean     :automatically_accept_payment_requests
      t.boolean     :generate_document_at_settlement_start

      t.timestamps
    end
  end
end
