class AddMemoToAgencies < ActiveRecord::Migration[6.1]
  def change
    add_column :agencies, :memo, :text
  end
end
