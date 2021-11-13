class ChangeColumnsFromStores < ActiveRecord::Migration[6.1]
  def change
    # remove_columns :stores, :store_id, :string

    # rename_column :stores, :store_code, :app_id

    # change_column  :stores, :ave_price, :integer, default: 0
    # change_column  :stores, :table_cnt, :integer, default: 0
    # change_column  :stores, :counter_cnt, :integer, default: 0
    # change_column  :stores, :menu_cnt, :integer, default: 0
    # change_column  :stores, :menu_photo_cnt, :integer, default: 0
    change_column  :stores, :progress_id, :bigint, default: 1
    change_column  :stores, :settlement_id, :bigint, default: 1
  end
end
