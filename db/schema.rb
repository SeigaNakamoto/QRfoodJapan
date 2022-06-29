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

ActiveRecord::Schema.define(version: 2022_06_24_055233) do

  create_table "admins", charset: "utf8mb3", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
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

  create_table "agencies", charset: "utf8mb3", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
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
    t.string "parent_agency_id"
    t.text "memo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "email", default: "", null: false
    t.index ["agency_id"], name: "index_agencies_on_agency_id", unique: true
    t.index ["reset_password_token"], name: "index_agencies_on_reset_password_token", unique: true
  end

  create_table "cancel_forms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "tel"
    t.string "shop_name"
    t.string "agent_shop_name"
    t.string "agent_charge_name"
    t.string "plan_name"
    t.boolean "treated", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "companies", charset: "utf8mb3", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "company_type", null: false
    t.string "corp_name"
    t.string "corp_postal"
    t.string "corp_add"
    t.string "corp_add_kana"
    t.string "corp_tel"
    t.string "corp_fax"
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
    t.text "memo"
  end

  create_table "payment_data", charset: "utf8mb3", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "master_order_number"
    t.string "payment_type"
    t.string "pay_result"
    t.string "sub_order_number"
    t.string "card_type"
    t.string "last_name"
    t.string "first_name"
    t.string "price"
    t.string "tax"
    t.string "shipping_cost"
    t.datetime "payment_date"
    t.string "payment_mode"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "plans", charset: "utf8mb3", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", null: false
    t.integer "sales_price", null: false
    t.integer "reward_price", null: false
    t.string "reward_style", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "order_num"
    t.index ["name"], name: "index_plans_on_name", unique: true
  end

  create_table "stores", charset: "utf8mb3", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "app_id"
    t.string "password_digest"
    t.string "store_name", null: false
    t.string "store_name_kana", null: false
    t.string "alphabet_notation"
    t.string "store_add", null: false
    t.string "store_add_kana", null: false
    t.string "store_tel", null: false
    t.string "store_fax"
    t.string "store_email"
    t.string "store_postal", null: false
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
    t.integer "ave_price", default: 0, null: false
    t.string "reservation", null: false
    t.integer "table_cnt", default: 0, null: false
    t.integer "counter_cnt", default: 0, null: false
    t.integer "menu_cnt", default: 0, null: false
    t.integer "menu_photo_cnt", default: 0, null: false
    t.string "bank_name", null: false
    t.string "bank_code", null: false
    t.string "bank_branch_name", null: false
    t.string "bank_branch_code", null: false
    t.string "bank_account_type", null: false
    t.string "bank_account_number", null: false
    t.string "bank_account_holder_kana", null: false
    t.integer "progress_status", default: 0, null: false
    t.integer "settlement_status", default: 0, null: false
    t.bigint "company_id", null: false
    t.bigint "agency_id", null: false
    t.string "agency_charge_id"
    t.string "agency_per_name"
    t.bigint "plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agency_id"], name: "index_stores_on_agency_id"
    t.index ["company_id"], name: "index_stores_on_company_id"
    t.index ["plan_id"], name: "index_stores_on_plan_id"
  end

  add_foreign_key "stores", "agencies"
  add_foreign_key "stores", "companies"
  add_foreign_key "stores", "plans"
end
