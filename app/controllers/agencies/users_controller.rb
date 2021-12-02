class Agencies::UsersController < ApplicationController
  # before_action :authenticate_agency!
  
  def new
      @company = Company.new
      @store = Store.new
      @plans = Plan.all

      if params[:agency_id] != nil then
        @store.agency_charge_id = params[:agency_id]
      end
  end
  
  def create
    @company = Company.new(company_params)
    @store = Store.new(store_params[:store])
    @plans = Plan.all

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
      redirect_to users_payment_path
    else
      render 'new'
    end
  end
  
  def payment
  end
  
  def termsofservice
  end
  
  def privacypolicy
  end
  
  private
  
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