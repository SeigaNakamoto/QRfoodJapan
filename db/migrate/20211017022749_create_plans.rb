class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.integer :sales_price, null: false
      t.integer :reward_price, null: false
      t.string :reward_style, null: false

      t.timestamps
    end
    add_index :plans, :name, unique: true
  end
end
