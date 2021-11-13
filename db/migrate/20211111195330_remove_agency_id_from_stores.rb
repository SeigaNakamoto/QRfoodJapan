class RemoveAgencyIdFromStores < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :stores, :agencies
    remove_index :stores, :agency_id
    remove_reference :stores, :agency
  end
end
