class CompaniesController < ApplicationController

  def new
      @company = Company.new
      @store = Store.new
      @plans = Plan.all
  end

  def create
    @company = Company.new(company_params)
    @store = Store.new(store_params[:store])
    @plans = Plan.all
    if @company.save | @store.save
      @store.company_id = @company.id
      if @store.save
        flash[:notice] = "【#{@store.store_name}】のQRfood加盟店登録申し込みが完了しました。"
        redirect_to new_company_path
      else
        render 'new'
      end
    else
      render 'new'
    end
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
      :corp_num,
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
        :agency_id,
        :agency_per_name,
        :company_id,
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
        :menu_cnt,
        :menu_photo_cnt,
        :bank_name,
        :bank_code,
        :bank_branch_name,
        :bank_branch_code,
        :bank_account_type,
        :bank_account_number,
        :bank_account_holder_kana,
        :credit_card_member_name,
        :credit_card_expiry_date,
        :credit_card_number,
        :plan_id,
        :plan_settlement,
        :agreement,
        :progress_status,
        :settlement_status
      ]
    )
  end
end