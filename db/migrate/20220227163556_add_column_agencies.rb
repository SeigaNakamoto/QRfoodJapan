class AddColumnAgencies < ActiveRecord::Migration[6.1]
  def change
    add_column :agencies, :email, :string, default: "", null: false
  end
end
