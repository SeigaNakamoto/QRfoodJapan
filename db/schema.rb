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

ActiveRecord::Schema.define(version: 2021_11_12_200631) do

  create_table "admins", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "agencies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "agency_id", null: false
    t.string "company_type", null: false
    t.string "agency_name", null: false
    t.string "agency_postal", null: false
    t.string "agency_add", null: false
    t.string "agency_rec_name", null: false
    t.string "agency_rec_tel", null: false
    t.string "agency_tel", null: false
    t.string "agency_mail", null: false
    t.string "bank_name", null: false
    t.string "bank_code", null: false
    t.string "bank_branch_name", null: false
    t.string "bank_branch_code", null: false
    t.string "bank_account_type", null: false
    t.string "bank_account_number", null: false
    t.string "bank_account_holder_kana", null: false
    t.string "parent_agency_id", default: "parent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_agencies_on_email", unique: true
    t.index ["reset_password_token"], name: "index_agencies_on_reset_password_token", unique: true
  end

  create_table "companies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "company_type", null: false
    t.string "corp_name"
    t.string "corp_postal"
    t.string "corp_add"
    t.string "corp_add_kana"
    t.string "corp_tel"
    t.string "corp_fax"
    t.string "corp_num"
    t.date "corp_date"
    t.string "rep_post", null: false
    t.string "rep_name", null: false
    t.string "rep_name_kana", null: false
    t.string "rep_postal", null: false
    t.string "rep_add", null: false
    t.string "rep_add_kana", null: false
    t.date "rep_birthdate", null: false
    t.string "rep_tel", null: false
    t.string "rep_email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "plans", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "sales_price", null: false
    t.integer "reward_price", null: false
    t.string "reward_style", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_plans_on_name", unique: true
  end

  create_table "progresses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_progresses_on_name", unique: true
  end

  create_table "settlements", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_settlements_on_name", unique: true
  end

  create_table "stores", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "store_id"
    t.string "store_code"
    t.string "store_name", null: false
    t.string "store_name_kana", null: false
    t.string "alphabet_notation"
    t.string "store_add", null: false
    t.string "store_add_kana", null: false
    t.string "store_tel", null: false
    t.string "store_fax"
    t.string "store_email"
    t.string "store_postal", null: false
    t.string "string", null: false
    t.string "per_post", null: false
    t.string "per_name", null: false
    t.string "per_name_kana", null: false
    t.string "per_tel", null: false
    t.string "per_email", null: false
    t.string "time_zone_to_contact", null: false
    t.string "genre", null: false
    t.string "business_hours", null: false
    t.string "regular_holiday", null: false
    t.text "hp"
    t.integer "ave_price", null: false
    t.string "reservation", null: false
    t.integer "table_cnt", null: false
    t.integer "counter_cnt", null: false
    t.integer "menu_cnt", null: false
    t.integer "menu_photo_cnt", null: false
    t.string "bank_name", null: false
    t.string "bank_code", null: false
    t.string "bank_branch_name", null: false
    t.string "bank_branch_code", null: false
    t.string "bank_account_type", null: false
    t.string "bank_account_number", null: false
    t.string "bank_account_holder_kana", null: false
    t.string "credit_card_member_name", null: false
    t.string "credit_card_expiry_date", null: false
    t.string "credit_card_number", null: false
    t.bigint "company_id", null: false
    t.string "agency_per_name"
    t.bigint "plan_id", null: false
    t.string "plan_settlement", null: false
    t.bigint "progress_id", default: 1, null: false
    t.bigint "settlement_id", default: 1, null: false
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "agency_id"
    t.integer "progress_status", default: 0, null: false
    t.integer "settlement_status", default: 0, null: false
    t.index ["company_id"], name: "index_stores_on_company_id"
    t.index ["plan_id"], name: "index_stores_on_plan_id"
    t.index ["progress_id"], name: "index_stores_on_progress_id"
    t.index ["settlement_id"], name: "index_stores_on_settlement_id"
    t.index ["store_code"], name: "index_stores_on_store_code", unique: true
  end

  add_foreign_key "stores", "companies"
  add_foreign_key "stores", "plans"
  add_foreign_key "stores", "progresses"
  add_foreign_key "stores", "settlements"
end
