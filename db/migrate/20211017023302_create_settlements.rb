class CreateSettlements < ActiveRecord::Migration[6.1]
  def change
    create_table :settlements do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :settlements, :name, unique: true
  end
end
