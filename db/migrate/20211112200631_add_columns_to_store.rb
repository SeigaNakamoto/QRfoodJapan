class AddColumnsToStore < ActiveRecord::Migration[6.1]
  def change
    add_column :stores, :progress_status, :integer, null: false, default: 0
    add_column :stores, :settlement_status, :integer, null: false, default: 0
  end
end
