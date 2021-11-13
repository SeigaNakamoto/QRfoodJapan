class CreateServiceoffers < ActiveRecord::Migration[6.1]
  def change
    create_table :serviceoffers do |t|
      t.references :store, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.integer :order, null: false

      t.timestamps
    end
  end
end
