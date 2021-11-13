# == Schema Information
#
# Table name: settlements
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_settlements_on_name  (name) UNIQUE
#
class Settlement < ApplicationRecord
end
