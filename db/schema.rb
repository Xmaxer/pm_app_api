# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_19_172124) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "algorithms", force: :cascade do |t|
    t.bigint "asset_id", null: false
    t.string "name", null: false
    t.integer "expected_features", null: false
    t.jsonb "settings", default: "{}", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["asset_id"], name: "index_algorithms_on_asset_id"
  end

  create_table "api_key_histories", force: :cascade do |t|
    t.bigint "api_key_id", null: false
    t.string "query"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["api_key_id"], name: "index_api_key_histories_on_api_key_id"
  end

  create_table "api_keys", force: :cascade do |t|
    t.string "api_key", null: false
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "deleted", default: false, null: false
    t.index ["api_key"], name: "index_api_keys_on_api_key", unique: true
    t.index ["company_id"], name: "index_api_keys_on_company_id"
    t.index ["user_id"], name: "index_api_keys_on_user_id"
  end

  create_table "assets", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "company_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "deleted", default: false, null: false
    t.index ["company_id"], name: "index_assets_on_company_id"
    t.index ["user_id"], name: "index_assets_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "dashboard_url"
    t.string "grafana_username"
    t.string "grafana_password"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "deleted", default: false, null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "company_roles", force: :cascade do |t|
    t.string "name", null: false
    t.string "colour", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_roles_on_company_id"
    t.index ["name", "company_id"], name: "unique_role_name_index", unique: true
  end

  create_table "user_company_roles", force: :cascade do |t|
    t.bigint "company_role_id", null: false
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_user_company_roles_on_company_id"
    t.index ["company_role_id", "user_id", "company_id"], name: "unique_user_company_role_index", unique: true
    t.index ["company_role_id"], name: "index_user_company_roles_on_company_role_id"
    t.index ["user_id"], name: "index_user_company_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name"
    t.string "password_digest"
    t.string "email", null: false
    t.string "phone_number"
    t.string "secret_key"
    t.boolean "enabled", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "unique_email_index", unique: true
    t.index ["phone_number"], name: "unique_phone_number_index", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "algorithms", "assets"
  add_foreign_key "api_key_histories", "api_keys"
  add_foreign_key "api_keys", "companies"
  add_foreign_key "api_keys", "users"
  add_foreign_key "assets", "companies"
  add_foreign_key "assets", "users"
  add_foreign_key "companies", "users"
  add_foreign_key "company_roles", "companies"
  add_foreign_key "user_company_roles", "companies"
  add_foreign_key "user_company_roles", "company_roles"
  add_foreign_key "user_company_roles", "users"
end
