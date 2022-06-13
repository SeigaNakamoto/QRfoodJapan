class AddColumnPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :order_num, :integer
  end
end
