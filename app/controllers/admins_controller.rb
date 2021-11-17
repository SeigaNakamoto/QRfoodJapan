class AdminsController < ApplicationController
  before_action :authenticate_admin!
  require 'csv'

  def index
    @companies = Company.joins(:stores).all

    @agencies = Agency.page(params[:page])
    @plans = Plan.all

  end
  
  def new
  end
  
  def show
  end
  
  def edit
  end
  
  def destroy
  end
  
  def store_list
    @companies = Company.joins(:stores).page(params[:page]).per(30)
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
  
  def agency_list
    @agencies = Agency.page(params[:page]).per(30)
    @plans = Plan.all

    @agenciescsv = Agency.all
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_agencies_csv(@agenciescsv)
      end
    end
  
    # @q = Agency.ransack(params[:q])
    # @agencies = @q.result.includes(:user).page(params[:page]).order("created_at desc")
  end

  private

  def send_agencies_csv(agencies)
    csv_data = CSV.generate do |csv|
      column_names = %w(代理店ID 代理店名 代理店TEL 代理店MAIL ライト スタンダード プレミアム 金融機関名 金融機関コード 支店名 支店コード 口座種別 口座名義（カナ） 口座番号)
      csv << column_names
      agencies.each do |agency|
        if agency.parent_agency_id.eql?("parent")
          column_values = [
            agency.agency_id,
            "【総合】" + agency.agency_name,
            agency.agency_tel,
            agency.agency_mail,
            Store.where('agency_id like ?',"Q#{agency.agency_id[1, 2]}%").where(plan_id: 1, settlement_status: [0,2]).count,
            Store.where('agency_id like ?',"Q#{agency.agency_id[1, 2]}%").where(plan_id: 2, settlement_status: [0,2]).count,
            Store.where('agency_id like ?',"Q#{agency.agency_id[1, 2]}%").where(plan_id: 3, settlement_status: [0,2]).count,
            agency.bank_name,
            agency.bank_code,
            agency.bank_branch_name,
            agency.bank_branch_code,
            agency.bank_account_type,
            agency.bank_account_number,
            agency.bank_account_holder_kana
          ]
        elsif agency.agency_id[4,3].eql?("001")
          column_values = [
            agency.agency_id,
            agency.agency_name,
            agency.agency_tel,
            agency.agency_mail,
            Store.where(agency_id: agency.agency_id, plan_id: 1, settlement_status: [0,2]).count,
            Store.where(agency_id: agency.agency_id, plan_id: 2, settlement_status: [0,2]).count,
            Store.where(agency_id: agency.agency_id, plan_id: 3, settlement_status: [0,2]).count,
            agency.bank_name,
            agency.bank_code,
            agency.bank_branch_name,
            agency.bank_branch_code,
            agency.bank_account_type,
            agency.bank_account_number,
            agency.bank_account_holder_kana
          ]
        else
          column_values = [
            agency.agency_id,
            agency.agency_name,
            agency.agency_tel,
            agency.agency_mail,
            Store.where(agency_id: agency.agency_id, plan_id: 1, settlement_status: [0,2]).count,
            Store.where(agency_id: agency.agency_id, plan_id: 2, settlement_status: [0,2]).count,
            Store.where(agency_id: agency.agency_id, plan_id: 3, settlement_status: [0,2]).count,
            agency.bank_name,
            agency.bank_code,
            agency.bank_branch_name,
            agency.bank_branch_code,
            agency.bank_account_type,
            agency.bank_account_number,
            agency.bank_account_holder_kana
          ]
        end
        csv << column_values
      end
    end
    send_data(csv_data, filename: "代理店一覧.csv")
  end

  def send_companies_csv(companies)
    csv_data = CSV.generate do |csv|
      column_names = %w(店舗ID 事業者名 店舗名 店舗TEL 店舗MAIL 代理店ID 代理店担当者名 申込日 進捗ステータス 決済ステータス 金融機関名 金融機関コード 支店名 支店コード 口座種別 口座名義（カナ） 口座番号)
      csv << column_names
      companies.each do |company|
        company.stores.each do |store|
          column_values = [
            store.id,
            company.corp_name,
            store.store_name,
            store.store_tel,
            store.store_email,
            store.agency_id,
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
