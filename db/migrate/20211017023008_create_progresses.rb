class CreateProgresses < ActiveRecord::Migration[6.1]
  def change
    create_table :progresses do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :progresses, :name, unique: true
  end
end
