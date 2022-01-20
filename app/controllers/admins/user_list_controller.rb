class Admins::UserListController < ApplicationController
  before_action :authenticate_admin!
  require 'csv'

  def index
    @companies = Company.order(id: :desc).joins(:stores).page(params[:page]).per(30)
    @plans = Plan.all

    @companiescsv = Company.joins(:stores).all
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_companies_csv(@companiescsv)
      end
    end

    # @q = Agency.ransack(params[:q])
    # @agencies = @q.result.includes(:user).page(params[:page]).order("created_at desc")
  end

  def show
    @company = Company.find(params[:id])
    @store = Store.find(@company.stores.first.id)
    @plans = Plan.all
  end

  def update
    @company = Company.find(params[:id])
    @store = Store.find(@company.stores.first.id)
    @plans = Plan.all
    if @company.update(company_params) & @store.update(store_params[:store])
      flash[:success] = "「#{@store.store_name}」のユーザー情報を変更しました。"
      redirect_to admins_user_list_path(@company.id)
    else
      render 'show'
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @store = Store.find(@company.stores.first.id)
    @store.delete
    @company.delete
    redirect_to admins_user_list_index_path
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
      :rep_email,
      :memo
    )
  end

  def store_params
    params.require(:company).permit(
      store:[
        :app_id,
        :password_digest,
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
        :bank_name,
        :bank_code,
        :bank_branch_name,
        :bank_branch_code,
        :bank_account_type,
        :bank_account_number,
        :bank_account_holder_kana,
        :plan_id,
        :agreement,
        :agreement_up,
        :progress_status,
        :settlement_status,
      ]
    )
  end

  def send_companies_csv(companies)
    csv_data = CSV.generate do |csv|
      column_names = %w(店舗ID 事業者名 店舗名 プラン名 店舗TEL 店舗MAIL 代理店ID 代理店担当者名 申込日 進捗ステータス 決済ステータス 金融機関名 金融機関コード 支店名 支店コード 口座種別 口座名義（カナ） 口座番号)
      csv << column_names
      companies.each do |company|
        company.stores.each do |store|
          column_values = [
            store.id,
            company.corp_name,
            store.store_name,
            Plan.where(id: store.plan_id).first.name,
            store.store_tel,
            store.store_email,
            store.agency.agency_id,
            store.agency_per_name,
            store.created_at.to_s(:datetime_jp_Ymd),
            store.progress_status_i18n,
            store.settlement_status_i18n,
            store.bank_name,
            store.bank_code,
            store.bank_branch_name,
            store.bank_branch_code,
            store.bank_account_type,
            store.bank_account_number,
            store.bank_account_holder_kana
          ]
          csv << column_values
        end
      end
    end
    send_data(csv_data, filename: "ユーザー一覧.csv")
  end

end
