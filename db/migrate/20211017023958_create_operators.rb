class CreateOperators < ActiveRecord::Migration[6.1]
  def change
    create_table :operators do |t|
      t.string :operator_name, null: false
      t.string :operator_name_kana, null: false
      t.string :email, null: false
      t.string :password_digest

      t.timestamps
    end
    add_index :operators, :email, unique: true
  end
end
