class CreateAgencies < ActiveRecord::Migration[6.1]
  def change
    create_table :agencies do |t|
      t.string :agency_id, null: false
      t.boolean :parent_flag, null: false
      t.string :company_type, null: false
      t.string :agency_name, null: false
      t.string :agency_postal, null: false
      t.string :agency_add, null: false
      t.string :agency_rec_name, null: false
      t.string :agency_rec_tel, null: false
      t.string :agency_tel, null: false
      t.string :agency_mail, null: false
      t.string :bank_name, null: false
      t.string :bank_code, null: false
      t.string :bank_branch_name, null: false
      t.string :bank_branch_code, null: false
      t.string :bank_account_type, null: false
      t.string :bank_account_number, null: false
      t.string :bank_account_holder_kana, null: false
      t.string :parent_agency_id, default: 'parent'
      t.timestamps
    end
  end
end
