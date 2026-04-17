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

ActiveRecord::Schema[7.2].define(version: 2026_04_15_112941) do
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
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "electricity_bills", force: :cascade do |t|
    t.bigint "house_room_id", null: false
    t.date "month"
    t.integer "units", default: 0
    t.integer "per_unit", default: 0
    t.decimal "amount", default: "0.0"
    t.integer "previous_units", default: 0
    t.integer "current_units", default: 0
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_room_id"], name: "index_electricity_bills_on_house_room_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "house_id", null: false
    t.string "expense_type"
    t.decimal "amount"
    t.text "description"
    t.date "expense_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_id"], name: "index_expenses_on_house_id"
  end

  create_table "house_rooms", force: :cascade do |t|
    t.bigint "house_id", null: false
    t.integer "room_number"
    t.decimal "rent"
    t.string "status", default: "vacant", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_id"], name: "index_house_rooms_on_house_id"
  end

  create_table "houses", force: :cascade do |t|
    t.string "house_name"
    t.string "address"
    t.string "owner_name"
    t.integer "owner_id"
    t.integer "no_of_rooms"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monthly_bills", force: :cascade do |t|
    t.bigint "house_id", null: false
    t.bigint "house_room_id", null: false
    t.bigint "tenant_id", null: false
    t.integer "month"
    t.integer "year"
    t.decimal "rent_amount"
    t.decimal "utility_amount"
    t.decimal "maintenance_amount"
    t.decimal "total_amount"
    t.decimal "paid_amount"
    t.string "status"
    t.date "due_date"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_id"], name: "index_monthly_bills_on_house_id"
    t.index ["house_room_id"], name: "index_monthly_bills_on_house_room_id"
    t.index ["tenant_id"], name: "index_monthly_bills_on_tenant_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.date "old_paid_on"
    t.string "payment_mode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tenant_id", null: false
    t.bigint "rent_id"
    t.date "payment_date"
    t.string "transaction_id"
    t.string "note"
    t.bigint "monthly_bill_id"
    t.index ["monthly_bill_id"], name: "index_payments_on_monthly_bill_id"
    t.index ["rent_id"], name: "index_payments_on_rent_id"
    t.index ["tenant_id"], name: "index_payments_on_tenant_id"
  end

  create_table "rents", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.string "month"
    t.decimal "rent_amount"
    t.decimal "electricity_share"
    t.decimal "total_amount"
    t.decimal "paid_amount", default: "0.0"
    t.decimal "due_amount"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_rents_on_tenant_id"
  end

  create_table "tenant_partners", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.string "gender"
    t.string "father_name"
    t.string "mother_name"
    t.string "father_contact"
    t.string "mother_contact"
    t.string "mobile"
    t.string "alternate_mobile"
    t.text "before_rent_address"
    t.text "permanent_address"
    t.string "postal_code"
    t.string "district"
    t.string "state"
    t.string "country"
    t.string "occupation"
    t.string "occupation_contact"
    t.text "occupation_address"
    t.string "document_type"
    t.string "document_number"
    t.string "document_file"
    t.string "profile_photo"
    t.string "vehicle_no"
    t.integer "no_of_partners"
    t.date "rent_start_date"
    t.date "rent_end_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_tenant_partners_on_tenant_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.bigint "house_room_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.string "gender"
    t.string "father_name"
    t.string "mother_name"
    t.string "father_contact"
    t.string "mother_contact"
    t.string "mobile"
    t.string "alternate_mobile"
    t.text "before_rent_address"
    t.text "permanent_address"
    t.string "postal_code"
    t.string "district"
    t.string "state"
    t.string "country"
    t.string "occupation"
    t.string "occupation_contact"
    t.text "occupation_address"
    t.string "document_type"
    t.string "document_number"
    t.string "document_file"
    t.string "profile_photo"
    t.string "vehicle_no"
    t.integer "no_of_partners"
    t.date "rent_start_date"
    t.date "rent_end_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_room_id"], name: "index_tenants_on_house_room_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "utility_bills", force: :cascade do |t|
    t.bigint "monthly_bill_id", null: false
    t.string "utility_type"
    t.decimal "start_unit"
    t.decimal "end_unit"
    t.decimal "unit_rate"
    t.decimal "total_units"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["monthly_bill_id"], name: "index_utility_bills_on_monthly_bill_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "vehicle_name"
    t.string "vehicle_no"
    t.string "owner_type", null: false
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "vehicle_type"
    t.index ["owner_type", "owner_id"], name: "index_vehicles_on_owner"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "electricity_bills", "house_rooms"
  add_foreign_key "expenses", "houses"
  add_foreign_key "house_rooms", "houses"
  add_foreign_key "monthly_bills", "house_rooms"
  add_foreign_key "monthly_bills", "houses"
  add_foreign_key "monthly_bills", "tenants"
  add_foreign_key "payments", "monthly_bills"
  add_foreign_key "payments", "rents"
  add_foreign_key "payments", "tenants"
  add_foreign_key "rents", "tenants"
  add_foreign_key "tenant_partners", "tenants"
  add_foreign_key "tenants", "house_rooms"
  add_foreign_key "utility_bills", "monthly_bills"
end
