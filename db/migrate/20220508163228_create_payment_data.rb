class CreatePaymentData < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_data do |t|
      t.string      :master_order_number
      t.string      :payment_type
      t.string      :pay_result
      t.string      :sub_order_number
      t.string      :card_type
      t.string      :last_name
      t.string      :first_name
      t.string      :price
      t.string      :tax
      t.string      :shipping_cost
      t.string      :payment_date
      t.string      :payment_mode
      t.timestamps
    end
  end
end
