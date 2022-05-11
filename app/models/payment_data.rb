# == Schema Information
#
# Table name: payment_data
#
#  id                  :bigint           not null, primary key
#  card_type           :string(255)
#  first_name          :string(255)
#  last_name           :string(255)
#  master_order_number :string(255)
#  pay_result          :string(255)
#  payment_date        :string(255)
#  payment_mode        :string(255)
#  payment_type        :string(255)
#  price               :string(255)
#  shipping_cost       :string(255)
#  sub_order_number    :string(255)
#  tax                 :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class PaymentData < ApplicationRecord
  #importメソッド
  def self.import(file)
    CSV.foreach(file.path, headers: true, encoding: 'BOM|UTF-8') do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      task = find_or_initialize_by(
        master_order_number: row["決済番号"], 
        payment_mode: row["システムモード"], 
        payment_date: row["決済日時"], 
        payment_type: row["決済タイプ"], 
        pay_result: row["結果"], 
        sub_order_number: row["オーダー"], 
        card_type: row["カードタイプ"], 
        last_name: row["名前"], 
        first_name: row["姓"], 
        price: row["金額"], 
        tax: row["税金"], 
        shipping_cost: row["送料"]
      ) 
      # CSVからデータを取得し、設定する
      task.attributes = row.to_hash.slice(*updatable_attributes)
      task.save!(validate: false)
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["master_order_number", "payment_mode", "payment_date", "payment_type", "pay_result", "sub_order_number", "card_type", "last_name", "first_name", "price", "tax", "shipping_cost", ]
  end
end
