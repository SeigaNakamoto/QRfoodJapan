# == Schema Information
#
# Table name: agencies
#
#  id                       :bigint           not null, primary key
#  agency_add               :string(255)      not null
#  agency_mail              :string(255)      not null
#  agency_name              :string(255)      not null
#  agency_postal            :string(255)      not null
#  agency_rec_name          :string(255)      not null
#  agency_rec_tel           :string(255)      not null
#  agency_tel               :string(255)      not null
#  bank_account_holder_kana :string(255)      not null
#  bank_account_number      :string(255)      not null
#  bank_account_type        :string(255)      not null
#  bank_branch_code         :string(255)      not null
#  bank_branch_name         :string(255)      not null
#  bank_code                :string(255)      not null
#  bank_name                :string(255)      not null
#  company_type             :string(255)      not null
#  encrypted_password       :string(255)      default(""), not null
#  remember_created_at      :datetime
#  reset_password_sent_at   :datetime
#  reset_password_token     :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  agency_id                :string(255)      not null
#  parent_agency_id         :string(255)
#
# Indexes
#
#  index_agencies_on_agency_id             (agency_id) UNIQUE
#  index_agencies_on_reset_password_token  (reset_password_token) UNIQUE
#
class Agency < ApplicationRecord
  has_many :stores
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :authentication_keys => [:agency_id]

  # No use email
  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  # Validation
  validate :parent_agency_id_check
  validates :company_type, presence: true
  validates :agency_name, presence: true
  validates :agency_postal, presence: true
  validates :agency_add, presence: true
  validates :agency_rec_name, presence: true
  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  validates :agency_rec_tel, presence: true, format: { with: VALID_PHONE_REGEX }
  validates :agency_tel, presence: true, format: { with: VALID_PHONE_REGEX }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :agency_mail, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :bank_name, presence: true
  validates :bank_code, presence: true, length: { is: 4 }
  validates :bank_branch_name, presence: true
  validates :bank_branch_code, presence: true, length: { is: 3 }
  validates :bank_account_type, presence: true
  validates :bank_account_number, presence: true, length: { is: 7 }
  validates :bank_account_holder_kana, presence: true

  def parent_agency_id_check
    unless parent_agency_id.blank? || (Agency.where(agency_id: parent_agency_id).exists? && parent_agency_id[4,3].eql?('000')) || (agency_id[4,3].eql?('000') && parent_agency_id.eql?('parent'))
      errors.add(:parent_agency_id, '有効な代理店IDを入力してください')
    end
  end

  # def update_without_current_password(params, *options)
  #   params.delete(:current_password)

  #   if params[:password].blank? && params[:password_confirmation].blank?
  #     params.delete(:password)
  #     params.delete(:password_confirmation)
  #   end

  #   result = update_attributes(params, *options)
  #   clean_up_passwords
  #   result
  # end
end