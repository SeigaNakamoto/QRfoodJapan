class Agencies::UsersController < ApplicationController
  # before_action :authenticate_agency!
  before_action :set_payment_id, only: [:entry_payment, :light_payment, :standard_payment, :premium_payment]
  require 'securerandom'

  def new
    @company = Company.new
    @store = Store.new
    if params[:plan_id] != nil then
      @plans = Plan.find(params[:plan_id])
    else
      @plans = Plan.find(session[:plan_id])
    end

    if params[:agency_id] != nil then
      @store.agency_charge_id = params[:agency_id]
    end
  end

  def create
    @company = Company.new(company_params)
    @store = Store.new(store_params[:store])
    @plans = Plan.find(@store.plan_id)
    session[:plan_id] = @plans.id

    if Agency.where(agency_id: @store.agency_charge_id).exists?
      @store.agency_id = Agency.where(agency_id: @store.agency_charge_id).first.id
      @store.valid?
    else
      @store.valid?
      @store.errors.add(:agency_charge_id, 'は登録されていない代理店IDです')
    end

    if @company.valid? & @store.errors.size.eql?(1)
      @company.save
      @store.company_id = @company.id
      @store.save
      NotificationMailer.registrer_to_store(@company, @store, @plans).deliver
      NotificationMailer.registrer_to_agent(@company, @store, @plans).deliver
      NotificationMailer.registrer_to_admin(@company, @store, @plans).deliver
      if @store.plan_id == 44
        redirect_to users_entry_payment_path(agency_id: @store.agency_charge_id)
      elsif @store.plan_id == 1
        redirect_to users_light_payment_path(agency_id: @store.agency_charge_id)
      elsif @store.plan_id == 2
        redirect_to users_standard_payment_path(agency_id: @store.agency_charge_id)
      else
        redirect_to users_premium_payment_path(agency_id: @store.agency_charge_id)

      end
    else
      render 'new'
    end
  end

  def entry_payment
    p '------------------------------------------------'
  end
  def light_payment
  end
  def standard_payment
  end
  def premium_payment
  end

  def paid
    @param = request.query_string
  end

  def termsofservice
  end

  def privacypolicy
  end

  private

  def set_payment_id
    # ランダムな数字がサブ決済番号に既に存在するか確認し、存在した場合繰り返しランダムな数字を生成する
    if @random_number.nil? || PaymentData.exists?(sub_order_number: @random_number)
      create_random_id
      set_payment_id
    end

    # agency_id（Q**-###） と ランダムな数字を組み合わせて下記のような文字列を生成する
    # 「Q**###1234567890123456」
    @payment_id = params[:agency_id].delete('-') + @random_number.to_s
  end

  def create_random_id
    # 16桁のランダムな数字を生成
    @random_number = SecureRandom.random_number(1000000000000000..9999999999999999)
  end

  def company_params
    params.require(:company).permit(
      :company_type,
      :corp_name,
      :corp_postal,
      :corp_add,
      :corp_add_kana,
      :corp_tel,
      :corp_fax,
      :corp_date,
      :rep_post,
      :rep_name,
      :rep_name_kana,
      :rep_postal,
      :rep_add,
      :rep_add_kana,
      :rep_birthdate,
      :rep_tel,
      :rep_email
    )
  end

  def store_params
    params.require(:company).permit(
      store:[
        :store_name,
        :store_name_kana,
        :alphabet_notation,
        :store_postal,
        :store_add,
        :store_add_kana,
        :store_tel,
        :store_fax,
        :store_email,
        :per_post,
        :per_name,
        :per_name_kana,
        :per_tel,
        :per_email,
        :time_zone_to_contact,
        :genre,
        :business_hours,
        :regular_holiday,
        :hp,
        :ave_price,
        :reservation,
        :table_cnt,
        :counter_cnt,
        :bank_name,
        :bank_code,
        :bank_branch_name,
        :bank_branch_code,
        :bank_account_type,
        :bank_account_number,
        :bank_account_holder_kana,
        :agency_id,
        :agency_charge_id,
        :agency_per_name,
        :company_id,
        :plan_id,
        :agreement,
        :agreement_up,
        :progress_status,
        :settlement_status
      ]
    )
  end
end
