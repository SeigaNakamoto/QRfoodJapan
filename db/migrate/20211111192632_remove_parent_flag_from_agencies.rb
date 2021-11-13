class RemoveParentFlagFromAgencies < ActiveRecord::Migration[6.1]
  def change
    remove_column :agencies, :parent_flag, :boolean
  end
end
