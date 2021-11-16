class DeviceChangeAgencies < ActiveRecord::Migration[6.1]
  def change
    remove_column :agencies, :email, :string
  end
end
