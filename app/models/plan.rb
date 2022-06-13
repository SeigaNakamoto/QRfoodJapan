# == Schema Information
#
# Table name: plans
#
#  id           :bigint           not null, primary key
#  name         :string(255)      not null
#  order_num    :integer
#  reward_price :integer          not null
#  reward_style :string(255)      not null
#  sales_price  :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_plans_on_name  (name) UNIQUE
#
class Plan < ApplicationRecord
    has_many :stores
end
