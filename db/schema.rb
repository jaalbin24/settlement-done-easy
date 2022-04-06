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

ActiveRecord::Schema.define(version: 2022_03_22_212943) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "release_form_id"
    t.integer "user_id"
    t.index ["release_form_id"], name: "index_comments_on_release_form_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "release_forms", force: :cascade do |t|
    t.string "law_firm_name", default: "Default Law Firm (FAKE! USED FOR TESTING PURPOSES!)", null: false
    t.string "insurance_company_name", default: "Default Insurance Co. (FAKE! USED FOR TESTING PURPOSES!)", null: false
    t.string "claim_number"
    t.string "policy_number"
    t.string "plaintiff_name"
    t.string "defendant_name"
    t.string "place_of_incident"
    t.string "incident_description"
    t.date "date_of_incident"
    t.float "settlement_amount", default: 0.0, null: false
    t.boolean "approved", default: false, null: false
    t.boolean "adjustment_needed", default: false, null: false
    t.boolean "signed", default: false, null: false
    t.integer "settlement_id"
    t.string "ds_envelope_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
    t.index ["settlement_id"], name: "index_release_forms_on_settlement_id"
  end

  create_table "settlements", force: :cascade do |t|
    t.string "claim_number"
    t.string "policy_number"
    t.float "settlement_amount"
    t.string "defendent_name"
    t.string "plaintiff_name"
    t.string "incident_location"
    t.date "incident_date"
    t.integer "stage", default: 1, null: false
    t.integer "status", default: 1, null: false
    t.string "stripe_product_id"
    t.string "stripe_price_id"
    t.boolean "document_approved", default: false, null: false
    t.boolean "document_needs_adjustment", default: false, null: false
    t.boolean "final_document_approved", default: false, null: false
    t.boolean "signature_requested", default: false, null: false
    t.boolean "document_signed", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "lawyer_id"
    t.integer "insurance_agent_id"
    t.index ["insurance_agent_id"], name: "index_settlements_on_insurance_agent_id"
    t.index ["lawyer_id"], name: "index_settlements_on_lawyer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "role"
    t.string "first_name"
    t.string "last_name"
    t.string "organization"
    t.string "stripe_account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "release_forms"
  add_foreign_key "comments", "users"
  add_foreign_key "settlements", "users", column: "insurance_agent_id"
  add_foreign_key "settlements", "users", column: "lawyer_id"
end
