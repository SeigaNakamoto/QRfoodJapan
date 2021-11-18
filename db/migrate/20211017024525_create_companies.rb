class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :company_type, null: false
      t.string :corp_name
      t.string :corp_postal
      t.string :corp_add
      t.string :corp_add_kana
      t.string :corp_tel
      t.string :corp_fax
      t.string :corp_num
      t.date :corp_date
      t.string :rep_post, null: false
      t.string :rep_name, null: false
      t.string :rep_name_kana, null: false
      t.string :rep_postal, null: false
      t.string :rep_add, null: false
      t.string :rep_add_kana, null: false
      t.date :rep_birthdate, null: false
      t.string :rep_tel, null: false
      t.string :rep_email, null: false

      t.timestamps
    end
  end
end
