class RenamePaymentDateColumnToPaymentData < ActiveRecord::Migration[6.1]
  def change
    change_column :payment_data, :payment_date, :datetime
  end
end
