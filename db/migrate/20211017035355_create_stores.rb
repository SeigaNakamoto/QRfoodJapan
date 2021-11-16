class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :store_id
      t.string :store_code
      t.string :store_name, null: false
      t.string :store_name_kana, null: false
      t.string :alphabet_notation
      t.string :store_add, null: false
      t.string :store_add_kana, null: false
      t.string :store_tel, null: false
      t.string :store_fax
      t.string :store_email
      t.string :store_postal, null: false
      t.string :per_post, null: false
      t.string :per_name, null: false
      t.string :per_name_kana, null: false
      t.string :per_tel, null: false
      t.string :per_email, null: false
      t.string :time_zone_to_contact, null: false
      t.string :genre, null: false
      t.string :business_hours, null: false
      t.string :regular_holiday, null: false
      t.text :hp
      t.integer :ave_price, null: false
      t.string :reservation, null: false
      t.integer :table_cnt, null: false
      t.integer :counter_cnt, null: false
      t.integer :menu_cnt, null: false
      t.integer :menu_photo_cnt, null: false
      t.string :bank_name, null: false
      t.string :bank_code, null: false
      t.string :bank_branch_name, null: false
      t.string :bank_branch_code, null: false
      t.string :bank_account_type, null: false
      t.string :bank_account_number, null: false
      t.string :bank_account_holder_kana, null: false
      t.string :credit_card_member_name, null: false
      t.string :credit_card_expiry_date, null: false
      t.string :credit_card_number, null: false
      t.references :company, null: false, foreign_key: true
      t.references :agency, null: false, foreign_key: true
      t.string :agency_per_name
      t.references :plan, null: false, foreign_key: true
      t.string :plan_settlement, null: false
      t.references :progress, null: false, from: nil, to: 1, foreign_key: true
      t.references :settlement, null: false, from: nil, to: 1, foreign_key: true
      t.string :password_digest

      t.timestamps
    end
    add_index :stores, :store_code, unique: true
  end
end
