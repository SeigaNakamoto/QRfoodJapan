# frozen_string_literal: true

# == Schema Information
#
# Table name: cancel_forms
#
#  id                :bigint           not null, primary key
#  agent_charge_name :string(255)
#  agent_shop_name   :string(255)
#  email             :string(255)
#  name              :string(255)
#  plan_name         :string(255)
#  shop_name         :string(255)
#  tel               :string(255)
#  treated           :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class CancelForm < ApplicationRecord
  validates :name, length: { maximum: 50 }, presence: true
  validates :email,
    length: { maximum: 50 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,},
    presence: true
  validates :tel,
    numericality: { only_integer: true },
    format: { with: /\A\d{10,11}\z/,}

  validates :shop_name, presence: true
  validates :agent_shop_name, presence: true
  validates :agent_charge_name, presence: true
  validates :plan_name, presence: true
end
