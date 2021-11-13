# == Schema Information
#
# Table name: companies
#
#  id            :bigint           not null, primary key
#  company_type  :string(255)      not null
#  corp_add      :string(255)
#  corp_add_kana :string(255)
#  corp_date     :date
#  corp_fax      :string(255)
#  corp_name     :string(255)
#  corp_num      :string(255)
#  corp_postal   :string(255)
#  corp_tel      :string(255)
#  rep_add       :string(255)      not null
#  rep_add_kana  :string(255)      not null
#  rep_birthdate :date             not null
#  rep_email     :string(255)      not null
#  rep_name      :string(255)      not null
#  rep_name_kana :string(255)      not null
#  rep_post      :string(255)      not null
#  rep_postal    :string(255)      not null
#  rep_tel       :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Company < ApplicationRecord
  has_many :stores
  accepts_nested_attributes_for :stores

  # Validation
    # VALID_POSTAL_REGEX = /\A\d{3}-\d{4}\z/
    VALID_PHONE_REGEX = /\A\d{10,11}\z/
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    # validates :company_type
    # validates :corp_name
    # validates :corp_postal, format: { with: VALID_POSTAL_REGEX }
    # validates :corp_add
    # validates :corp_add_kana
    # validates :corp_tel, format: { with: VALID_PHONE_REGEX }
    # validates :corp_fax, format: { with: VALID_PHONE_REGEX }
    # validates :corp_num, length: { is: 13 }
    # validates :corp_date
    validates :rep_post        , presence: true
    validates :rep_name        , presence: true
    validates :rep_name_kana   , presence: true
    validates :rep_postal      , presence: true
    validates :rep_add         , presence: true
    validates :rep_add_kana    , presence: true
    # validates :rep_birthdate
    validates :rep_tel         , presence: true, format: { with: VALID_PHONE_REGEX }
    validates :rep_email       , presence: true, format: { with: VALID_EMAIL_REGEX }

end
