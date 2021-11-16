# == Schema Information
#
# Table name: stores
#
#  id                       :bigint           not null, primary key
#  agency_per_name          :string(255)
#  alphabet_notation        :string(255)
#  ave_price                :integer          default(0), not null
#  bank_account_holder_kana :string(255)      not null
#  bank_account_number      :string(255)      not null
#  bank_account_type        :string(255)      not null
#  bank_branch_code         :string(255)      not null
#  bank_branch_name         :string(255)      not null
#  bank_code                :string(255)      not null
#  bank_name                :string(255)      not null
#  business_hours           :string(255)      not null
#  counter_cnt              :integer          default(0), not null
#  genre                    :string(255)      not null
#  hp                       :text(65535)
#  menu_cnt                 :integer          default(0), not null
#  menu_photo_cnt           :integer          default(0), not null
#  password_digest          :string(255)
#  per_email                :string(255)      not null
#  per_name                 :string(255)      not null
#  per_name_kana            :string(255)      not null
#  per_post                 :string(255)      not null
#  per_tel                  :string(255)      not null
#  plan_settlement          :string(255)      not null
#  progress_status          :integer          default("photo_waiting"), not null
#  regular_holiday          :string(255)      not null
#  reservation              :string(255)      not null
#  settlement_status        :integer          default("no_problem"), not null
#  store_add                :string(255)      not null
#  store_add_kana           :string(255)      not null
#  store_email              :string(255)
#  store_fax                :string(255)
#  store_name               :string(255)      not null
#  store_name_kana          :string(255)      not null
#  store_postal             :string(255)      not null
#  store_tel                :string(255)      not null
#  table_cnt                :integer          default(0), not null
#  time_zone_to_contact     :string(255)      not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  agency_id                :string(255)
#  app_id                   :string(255)
#  company_id               :bigint           not null
#  plan_id                  :bigint           not null
#
# Indexes
#
#  index_stores_on_app_id      (app_id) UNIQUE
#  index_stores_on_company_id  (company_id)
#  index_stores_on_plan_id     (plan_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (plan_id => plans.id)
#
class Store < ApplicationRecord
  belongs_to :company
  # belongs_to :agency
  belongs_to :plan

  #enum
  enum progress_status: { photo_waiting: 0, univapay_waiting: 1, no_problem: 2 }, _prefix: :progress
  enum settlement_status: { no_problem: 0, delinquent: 1, cancellation_reservation: 2, canceled: 3 }, _prefix: :settlement
  # enum progress_status: { "写真納品待ち": 0, "UnivaPay審査待ち": 1, "問題なし": 2 }, _prefix: :progress
  # enum settlement_status: { "問題なし": 0, "滞納中": 1, "解約予約": 2, "解約済み": 3 }, _prefix: :settlement

  # Validation
  VALID_PHONE_REGEX = /\A\d{10,11}\z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    # validates :agency_id
    # validates :agency_per_name
    # validates :company_id
    validates :store_name               , presence: true
    validates :store_name_kana          , presence: true
    # validates :alphabet_notation
    validates :store_postal             , presence: true
    validates :store_add                , presence: true
    validates :store_add_kana           , presence: true
    validates :store_tel                , presence: true, format: { with: VALID_PHONE_REGEX }
    # validates :store_fax                                , format: { with: VALID_PHONE_REGEX }
    # validates :store_email                              , format: { with: VALID_EMAIL_REGEX }
    validates :per_post                 , presence: true
    validates :per_name                 , presence: true
    validates :per_name_kana            , presence: true
    validates :per_tel                  , presence: true, format: { with: VALID_PHONE_REGEX }
    validates :per_email                , presence: true, format: { with: VALID_EMAIL_REGEX }
    validates :time_zone_to_contact     , presence: true
    validates :genre                    , presence: true
    validates :business_hours           , presence: true
    validates :regular_holiday          , presence: true
    # validates :hp
    validates :ave_price                , presence: true, numericality: true
    # validates :reservation
    validates :table_cnt                , presence: true, numericality: true
    validates :counter_cnt              , presence: true, numericality: true
    validates :menu_cnt                 , presence: true, numericality: true
    validates :menu_photo_cnt           , presence: true, numericality: true
    validates :bank_name                , presence: true
    validates :bank_code                , presence: true, length: { is: 4 }, numericality: true
    validates :bank_branch_name         , presence: true
    validates :bank_branch_code         , presence: true, length: { is: 3 }, numericality: true
    validates :bank_account_type        , presence: true
    validates :bank_account_number      , presence: true, length: { is: 7 }, numericality: true
    validates :bank_account_holder_kana , presence: true
    validates :plan_id                  , presence: true, presence: { message: 'を選択してください' }
    # validates :plan_settlement

    validates_acceptance_of :agreement, allow_nil: false, on: :create, message: 'に同意してください'

end
