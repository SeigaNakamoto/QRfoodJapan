class Admins::AgencyListController < ApplicationController
  before_action :authenticate_admin!
  require 'csv'

  def index
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

  def show
    @agency = Agency.find(params[:id])
  end

  def update
    @agency = Agency.find(params[:id])
    if @agency.update(agency_params)
      flash[:success] = "「#{@agency.agency_name}」の代理店情報を変更しました。"
      redirect_to admins_agency_list_path(@agency.id)
    else
      render 'show'
    end

  end

  private

  def agency_params
    params.require(:agency).permit(
      :company_type,
      :agency_name,
      :agency_postal,
      :agency_add,
      :agency_rec_name,
      :agency_rec_tel,
      :agency_tel,
      :agency_mail,
      :bank_name,
      :bank_code,
      :bank_branch_name,
      :bank_branch_code,
      :bank_account_type,
      :bank_account_number,
      :bank_account_holder_kana
    )
  end

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

end
