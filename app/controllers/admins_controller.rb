class AdminsController < ApplicationController
  before_action :authenticate_admin!
  require 'csv'

  def index
    @companies = Company.joins(:stores).all

    @agencies = Agency.page(params[:page])
    @plans = Plan.all

    @agenciescsv = Agency.all
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_agencies_csv(@agenciescsv)
      end
    end

    @q = Agency.ransack(params[:q])
    @agencies = @q.result.includes(:user).page(params[:page]).order("created_at desc")
  end

  def new
  end

  def show
  end

  def edit
  end

  def destroy
  end

  def agencies
    @agencies = Agency.page(params[:page])
    @plans = Plan.all
  end

  def stores
    @companies = Company.joins(:stores).all
  end

  private

  def send_agencies_csv(agencies)
    csv_data = CSV.generate do |csv|
      column_names = %w(代理店ID 代理店名 代理店TEL 代理店MAIL ライト スタンダード プレミアム 金融機関名 金融機関コード 支店名 支店コード 口座種別 口座名義（カナ） 口座番号)
      csv << column_names
      agencies.each do |agency|
        column_values = [
          agency.agency_id,
          agency.agency_name,
          agency.agency_tel,
          agency.agency_mail,
          Store.where(agency_id: agency.id, plan_id: 1).count,
          Store.where(agency_id: agency.id, plan_id: 2).count,
          Store.where(agency_id: agency.id, plan_id: 3).count,
          agency.bank_name,
          agency.bank_code,
          agency.bank_branch_name,
          agency.bank_branch_code,
          agency.bank_account_type,
          agency.bank_account_number,
          agency.bank_account_holder_kana
        ]
        csv << column_values
      end
    end
    send_data(csv_data, filename: "代理店一覧.csv")
  end
end
