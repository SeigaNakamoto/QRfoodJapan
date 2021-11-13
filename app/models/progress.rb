# == Schema Information
#
# Table name: progresses
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_progresses_on_name  (name) UNIQUE
#
class Progress < ApplicationRecord
end
