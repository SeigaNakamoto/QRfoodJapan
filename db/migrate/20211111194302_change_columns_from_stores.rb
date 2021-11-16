class ChangeColumnsFromStores < ActiveRecord::Migration[6.1]
  def change
    remove_columns :stores, :store_id, :credit_card_member_name, :credit_card_expiry_date, :credit_card_number

    # remove_columns :stores, :store_id, :string
    # remove_columns :stores, :credit_card_member_name, :string
    # remove_columns :stores, :credit_card_expiry_date, :string
    # remove_columns :stores, :credit_card_number, :string

    rename_column :stores, :store_code, :app_id

    change_column  :stores, :ave_price, :integer, default: 0
    change_column  :stores, :table_cnt, :integer, default: 0
    change_column  :stores, :counter_cnt, :integer, default: 0
    change_column  :stores, :menu_cnt, :integer, default: 0
    change_column  :stores, :menu_photo_cnt, :integer, default: 0
    change_column  :stores, :progress_id, :bigint, default: 1
    change_column  :stores, :settlement_id, :bigint, default: 1

    remove_foreign_key :stores, :progresses
    remove_index :stores, :progress_id
    remove_reference :stores, :progress
    remove_foreign_key :stores, :settlements
    remove_index :stores, :settlement_id
    remove_reference :stores, :settlement

    drop_table :progresses
    drop_table :settlements

  end
end
