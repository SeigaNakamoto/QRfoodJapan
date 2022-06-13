class CancelForms < ActiveRecord::Migration[6.1]
  def change
    create_table :cancel_forms do |t|
      t.string      :email
      t.string      :name
      t.string      :tel
      t.string      :shop_name
      t.string      :agent_shop_name
      t.string      :agent_charge_name
      t.string      :plan_name
      t.boolean     :treated, default: false
      t.timestamps
    end
  end
end
