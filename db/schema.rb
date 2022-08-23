# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_03_20_154344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.string "stripe_payment_method_id", null: false
    t.string "nickname"
    t.integer "last4", limit: 2
    t.string "fingerprint"
    t.string "status"
    t.boolean "default", default: false, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stripe_payment_method_id"], name: "index_bank_accounts_on_stripe_payment_method_id", unique: true
    t.index ["user_id"], name: "index_bank_accounts_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "document_id"
    t.bigint "user_id"
    t.index ["document_id"], name: "index_comments_on_document_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "document_log_entries", force: :cascade do |t|
    t.bigint "document_id"
    t.bigint "user_id"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_id"], name: "index_document_log_entries_on_document_id"
    t.index ["user_id"], name: "index_document_log_entries_on_user_id"
  end

  create_table "document_review_log_entries", force: :cascade do |t|
    t.bigint "document_review_id"
    t.bigint "user_id"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_review_id"], name: "index_document_review_log_entries_on_document_review_id"
    t.index ["user_id"], name: "index_document_review_log_entries_on_user_id"
  end

  create_table "document_reviews", force: :cascade do |t|
    t.bigint "reviewer_id"
    t.bigint "document_id"
    t.string "verdict", default: "Waiting", null: false
    t.string "reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_id"], name: "index_document_reviews_on_document_id"
    t.index ["reviewer_id"], name: "index_document_reviews_on_reviewer_id"
  end

  create_table "documents", force: :cascade do |t|
    t.boolean "signed", default: false, null: false
    t.boolean "needs_signature", default: false, null: false
    t.boolean "auto_generated", default: false, null: false
    t.string "status", default: "Waiting for review", null: false
    t.bigint "settlement_id"
    t.bigint "added_by_id"
    t.string "ds_envelope_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["added_by_id"], name: "index_documents_on_added_by_id"
    t.index ["settlement_id"], name: "index_documents_on_settlement_id"
  end

  create_table "payment_log_entries", force: :cascade do |t|
    t.bigint "payment_id"
    t.bigint "user_id"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["payment_id"], name: "index_payment_log_entries_on_payment_id"
    t.index ["user_id"], name: "index_payment_log_entries_on_user_id"
  end

  create_table "payment_request_log_entries", force: :cascade do |t|
    t.bigint "payment_request_id"
    t.bigint "user_id"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["payment_request_id"], name: "index_payment_request_log_entries_on_payment_request_id"
    t.index ["user_id"], name: "index_payment_request_log_entries_on_user_id"
  end

  create_table "payment_requests", force: :cascade do |t|
    t.bigint "requester_id"
    t.bigint "accepter_id"
    t.bigint "settlement_id"
    t.string "status", default: "Requested", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accepter_id"], name: "index_payment_requests_on_accepter_id"
    t.index ["requester_id"], name: "index_payment_requests_on_requester_id"
    t.index ["settlement_id"], name: "index_payment_requests_on_settlement_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "settlement_id"
    t.bigint "source_id"
    t.bigint "destination_id"
    t.string "status", default: "Not sent", null: false
    t.string "stripe_inbound_transfer_id"
    t.string "stripe_outbound_payment_id"
    t.string "stripe_outbound_transfer_id"
    t.float "amount", null: false
    t.datetime "completed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["destination_id"], name: "index_payments_on_destination_id"
    t.index ["settlement_id"], name: "index_payments_on_settlement_id"
    t.index ["source_id"], name: "index_payments_on_source_id"
    t.index ["stripe_inbound_transfer_id"], name: "index_payments_on_stripe_inbound_transfer_id", unique: true
    t.index ["stripe_outbound_payment_id"], name: "index_payments_on_stripe_outbound_payment_id", unique: true
    t.index ["stripe_outbound_transfer_id"], name: "index_payments_on_stripe_outbound_transfer_id", unique: true
  end

  create_table "settlement_log_entries", force: :cascade do |t|
    t.bigint "settlement_id"
    t.bigint "user_id"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["settlement_id"], name: "index_settlement_log_entries_on_settlement_id"
    t.index ["user_id"], name: "index_settlement_log_entries_on_user_id"
  end

  create_table "settlements", force: :cascade do |t|
    t.string "claim_number"
    t.string "policy_number"
    t.float "dollar_amount"
    t.string "defendant_name"
    t.string "plaintiff_name"
    t.string "incident_location"
    t.date "incident_date"
    t.integer "stage", default: 1, null: false
    t.integer "status", default: 1, null: false
    t.boolean "signature_requested", default: false, null: false
    t.boolean "payment_made", default: false, null: false
    t.boolean "payment_received", default: false, null: false
    t.boolean "payment_has_error", default: false, null: false
    t.boolean "completed", default: false, null: false
    t.bigint "attorney_id"
    t.bigint "insurance_agent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attorney_id"], name: "index_settlements_on_attorney_id"
    t.index ["insurance_agent_id"], name: "index_settlements_on_insurance_agent_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "role"
    t.string "first_name"
    t.string "last_name"
    t.string "business_name"
    t.string "stripe_account_id"
    t.string "stripe_financial_account_id"
    t.boolean "stripe_account_onboarded", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organization_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["stripe_account_id"], name: "index_users_on_stripe_account_id", unique: true
    t.index ["stripe_financial_account_id"], name: "index_users_on_stripe_financial_account_id", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bank_accounts", "users"
  add_foreign_key "comments", "documents"
  add_foreign_key "comments", "users"
  add_foreign_key "document_log_entries", "documents"
  add_foreign_key "document_log_entries", "users"
  add_foreign_key "document_review_log_entries", "document_reviews"
  add_foreign_key "document_review_log_entries", "users"
  add_foreign_key "document_reviews", "documents"
  add_foreign_key "document_reviews", "users", column: "reviewer_id"
  add_foreign_key "documents", "settlements"
  add_foreign_key "documents", "users", column: "added_by_id"
  add_foreign_key "payment_log_entries", "payments"
  add_foreign_key "payment_log_entries", "users"
  add_foreign_key "payment_request_log_entries", "payment_requests"
  add_foreign_key "payment_request_log_entries", "users"
  add_foreign_key "payment_requests", "settlements"
  add_foreign_key "payment_requests", "users", column: "accepter_id"
  add_foreign_key "payment_requests", "users", column: "requester_id"
  add_foreign_key "payments", "bank_accounts", column: "destination_id"
  add_foreign_key "payments", "bank_accounts", column: "source_id"
  add_foreign_key "payments", "settlements"
  add_foreign_key "settlement_log_entries", "settlements"
  add_foreign_key "settlement_log_entries", "users"
  add_foreign_key "settlements", "users", column: "attorney_id"
  add_foreign_key "settlements", "users", column: "insurance_agent_id"
  add_foreign_key "users", "users", column: "organization_id"
end
