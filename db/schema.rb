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

ActiveRecord::Schema.define(version: 2023_02_28_185141) do

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

  create_table "addresses", force: :cascade do |t|
    t.string "public_id"
    t.string "line1"
    t.string "line2"
    t.string "city"
    t.string "postal_code"
    t.string "state"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "document_reviews", force: :cascade do |t|
    t.string "public_id"
    t.bigint "reviewer_id"
    t.bigint "document_id"
    t.string "verdict", default: "Waiting", null: false
    t.string "reason"
    t.bigint "log_book_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_id"], name: "index_document_reviews_on_document_id"
    t.index ["log_book_id"], name: "index_document_reviews_on_log_book_id"
    t.index ["reviewer_id"], name: "index_document_reviews_on_reviewer_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "public_id"
    t.boolean "signed"
    t.boolean "needs_signature"
    t.boolean "auto_generated"
    t.string "status", default: "Waiting for review", null: false
    t.string "nickname"
    t.bigint "settlement_id"
    t.bigint "added_by_id"
    t.string "ds_envelope_id"
    t.bigint "log_book_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["added_by_id"], name: "index_documents_on_added_by_id"
    t.index ["log_book_id"], name: "index_documents_on_log_book_id"
    t.index ["settlement_id"], name: "index_documents_on_settlement_id"
  end

  create_table "log_book_entries", force: :cascade do |t|
    t.string "public_id"
    t.bigint "log_book_id"
    t.bigint "user_id"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["log_book_id"], name: "index_log_book_entries_on_log_book_id"
    t.index ["user_id"], name: "index_log_book_entries_on_user_id"
  end

  create_table "log_books", force: :cascade do |t|
    t.string "public_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "public_id"
    t.bigint "user_id"
    t.string "title"
    t.string "message"
    t.boolean "seen"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "public_id"
    t.string "type"
    t.boolean "default"
    t.string "stripe_id"
    t.integer "last4", limit: 2
    t.string "nickname"
    t.string "bank_name"
    t.string "country"
    t.string "currency"
    t.string "status"
    t.integer "exp_month"
    t.integer "exp_year"
    t.bigint "added_by_id"
    t.bigint "address_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["added_by_id"], name: "index_payment_methods_on_added_by_id"
    t.index ["address_id"], name: "index_payment_methods_on_address_id"
  end

  create_table "payment_requests", force: :cascade do |t|
    t.string "public_id"
    t.bigint "requester_id"
    t.bigint "accepter_id"
    t.bigint "settlement_id"
    t.string "status", default: "Requested", null: false
    t.bigint "log_book_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accepter_id"], name: "index_payment_requests_on_accepter_id"
    t.index ["log_book_id"], name: "index_payment_requests_on_log_book_id"
    t.index ["requester_id"], name: "index_payment_requests_on_requester_id"
    t.index ["settlement_id"], name: "index_payment_requests_on_settlement_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "public_id"
    t.bigint "settlement_id"
    t.string "status", null: false
    t.string "stripe_inbound_transfer_id"
    t.string "stripe_outbound_payment_id"
    t.string "stripe_outbound_transfer_id"
    t.float "amount", null: false
    t.datetime "completed_at"
    t.datetime "started_at"
    t.bigint "log_book_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["log_book_id"], name: "index_payments_on_log_book_id"
    t.index ["settlement_id"], name: "index_payments_on_settlement_id"
    t.index ["stripe_inbound_transfer_id"], name: "index_payments_on_stripe_inbound_transfer_id", unique: true
    t.index ["stripe_outbound_payment_id"], name: "index_payments_on_stripe_outbound_payment_id", unique: true
    t.index ["stripe_outbound_transfer_id"], name: "index_payments_on_stripe_outbound_transfer_id", unique: true
  end

  create_table "settlement_attributes_reviews", force: :cascade do |t|
    t.string "public_id"
    t.string "status"
    t.bigint "settlement_id"
    t.bigint "user_id"
    t.boolean "amount_approved"
    t.boolean "claimant_name_approved"
    t.boolean "policy_holder_name_approved"
    t.boolean "claim_number_approved"
    t.boolean "policy_number_approved"
    t.boolean "incident_date_approved"
    t.boolean "incident_location_approved"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["settlement_id"], name: "index_settlement_attributes_reviews_on_settlement_id"
    t.index ["user_id"], name: "index_settlement_attributes_reviews_on_user_id"
  end

  create_table "settlement_settings", force: :cascade do |t|
    t.string "public_id"
    t.bigint "user_id"
    t.bigint "settlement_id"
    t.boolean "replace_unsigned_document_with_signed_document"
    t.boolean "alert_when_settlement_ready_for_payment"
    t.boolean "alert_when_payment_requested"
    t.boolean "confirmation_before_document_rejection"
    t.boolean "delete_my_documents_after_rejection"
    t.boolean "automatically_accept_payment_requests"
    t.boolean "generate_document_at_settlement_start"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["settlement_id"], name: "index_settlement_settings_on_settlement_id"
    t.index ["user_id"], name: "index_settlement_settings_on_user_id"
  end

  create_table "settlements", force: :cascade do |t|
    t.string "public_id"
    t.string "claim_number"
    t.string "policy_number"
    t.float "amount"
    t.string "policy_holder_name"
    t.string "claimant_name"
    t.string "incident_location"
    t.date "incident_date"
    t.integer "public_number"
    t.boolean "locked", default: false, null: false
    t.boolean "completed", default: false, null: false
    t.boolean "canceled", default: false, null: false
    t.boolean "ready_for_payment", default: false, null: false
    t.bigint "started_by_id"
    t.bigint "attorney_id"
    t.bigint "adjuster_id"
    t.bigint "log_book_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["adjuster_id"], name: "index_settlements_on_adjuster_id"
    t.index ["attorney_id"], name: "index_settlements_on_attorney_id"
    t.index ["log_book_id"], name: "index_settlements_on_log_book_id"
    t.index ["started_by_id"], name: "index_settlements_on_started_by_id"
  end

  create_table "signatures", force: :cascade do |t|
    t.string "public_id"
    t.integer "corner1_x"
    t.integer "corner1_y"
    t.integer "corner2_x"
    t.integer "corner2_y"
    t.string "signer_email"
    t.string "status"
    t.bigint "document_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_id"], name: "index_signatures_on_document_id"
  end

  create_table "stripe_account_requirements", force: :cascade do |t|
    t.string "public_id"
    t.bigint "stripe_account_id"
    t.string "status"
    t.string "required_item"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stripe_account_id"], name: "index_stripe_account_requirements_on_stripe_account_id"
  end

  create_table "stripe_accounts", force: :cascade do |t|
    t.string "public_id"
    t.string "stripe_id"
    t.bigint "user_id"
    t.boolean "card_payments_enabled"
    t.boolean "transfers_enabled"
    t.boolean "us_bank_account_ach_payments_enabled"
    t.boolean "treasury_enabled"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stripe_id"], name: "index_stripe_accounts_on_stripe_id", unique: true
    t.index ["user_id"], name: "index_stripe_accounts_on_user_id"
  end

  create_table "stripe_financial_accounts", force: :cascade do |t|
    t.string "stripe_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stripe_setup_intents", force: :cascade do |t|
    t.string "public_id"
    t.string "payment_method_type"
    t.bigint "payment_method_id"
    t.bigint "created_by_id"
    t.string "stripe_id"
    t.string "stripe_account_id"
    t.string "client_secret"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_stripe_setup_intents_on_created_by_id"
    t.index ["payment_method_id"], name: "index_stripe_setup_intents_on_payment_method_id"
  end

  create_table "user_profile_settings", force: :cascade do |t|
    t.string "public_id"
    t.boolean "show_tax_id_to_public"
    t.boolean "show_tax_id_to_members_only"
    t.boolean "show_product_description_to_public"
    t.boolean "show_product_description_to_members_only"
    t.boolean "show_mcc_to_public"
    t.boolean "show_mcc_to_members_only"
    t.boolean "show_last_name_to_public"
    t.boolean "show_last_name_to_members_only"
    t.boolean "show_legal_name_to_public"
    t.boolean "show_legal_name_to_members_only"
    t.boolean "show_phone_number_to_public"
    t.boolean "show_phone_number_to_members_only"
    t.boolean "show_email_to_public"
    t.boolean "show_email_to_members_only"
    t.boolean "show_address_to_public"
    t.boolean "show_address_to_members_only"
    t.boolean "show_date_of_birth_to_public"
    t.boolean "show_date_of_birth_to_members_only"
    t.boolean "show_relationship_to_business_to_public"
    t.boolean "show_relationship_to_business_to_members_only"
    t.boolean "show_percent_ownership_to_public"
    t.boolean "show_percent_ownership_to_members_only"
    t.boolean "show_last_4_of_ssn_to_public"
    t.boolean "show_last_4_of_ssn_to_members_only"
    t.bigint "user_settings_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_settings_id"], name: "index_user_profile_settings_on_user_settings_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.string "public_id"
    t.string "first_name"
    t.string "last_name"
    t.string "public_name"
    t.string "legal_name"
    t.bigint "phone_number"
    t.string "email"
    t.date "date_of_birth"
    t.string "relationship_to_business"
    t.integer "percent_ownership"
    t.integer "last_4_of_ssn"
    t.integer "mcc"
    t.string "tax_id"
    t.string "product_description"
    t.bigint "address_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_id"], name: "index_user_profiles_on_address_id"
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "user_settings", force: :cascade do |t|
    t.string "public_id"
    t.boolean "replace_unsigned_document_with_signed_document"
    t.boolean "alert_when_settlement_ready_for_payment"
    t.boolean "alert_when_payment_requested"
    t.boolean "confirmation_before_document_rejection"
    t.boolean "delete_my_documents_after_rejection"
    t.boolean "automatically_accept_payment_requests"
    t.boolean "generate_document_at_settlement_start"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "public_id"
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
    t.string "stripe_financial_account_id"
    t.bigint "phone_number"
    t.boolean "activated", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organization_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["stripe_financial_account_id"], name: "index_users_on_stripe_financial_account_id", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "document_reviews", "documents"
  add_foreign_key "document_reviews", "log_books"
  add_foreign_key "document_reviews", "users", column: "reviewer_id"
  add_foreign_key "documents", "log_books"
  add_foreign_key "documents", "settlements"
  add_foreign_key "documents", "users", column: "added_by_id"
  add_foreign_key "log_book_entries", "log_books"
  add_foreign_key "log_book_entries", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "payment_methods", "addresses"
  add_foreign_key "payment_methods", "users", column: "added_by_id"
  add_foreign_key "payment_requests", "log_books"
  add_foreign_key "payment_requests", "settlements"
  add_foreign_key "payment_requests", "users", column: "accepter_id"
  add_foreign_key "payment_requests", "users", column: "requester_id"
  add_foreign_key "payments", "log_books"
  add_foreign_key "payments", "settlements"
  add_foreign_key "settlement_attributes_reviews", "settlements"
  add_foreign_key "settlement_attributes_reviews", "users"
  add_foreign_key "settlement_settings", "settlements"
  add_foreign_key "settlement_settings", "users"
  add_foreign_key "settlements", "log_books"
  add_foreign_key "settlements", "users", column: "adjuster_id"
  add_foreign_key "settlements", "users", column: "attorney_id"
  add_foreign_key "settlements", "users", column: "started_by_id"
  add_foreign_key "signatures", "documents"
  add_foreign_key "stripe_account_requirements", "stripe_accounts"
  add_foreign_key "stripe_accounts", "users"
  add_foreign_key "stripe_setup_intents", "payment_methods"
  add_foreign_key "stripe_setup_intents", "users", column: "created_by_id"
  add_foreign_key "user_profile_settings", "user_settings", column: "user_settings_id"
  add_foreign_key "user_profiles", "addresses"
  add_foreign_key "user_profiles", "users"
  add_foreign_key "user_settings", "users"
  add_foreign_key "users", "users", column: "organization_id"
end
