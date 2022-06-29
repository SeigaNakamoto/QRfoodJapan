class Admins::AgencyListController < ApplicationController
  before_action :authenticate_admin!
  require 'csv'

  def index
    @agencies = Agency.order(:agency_id).page(params[:page]).per(30)
    @plans = Plan.order(:order_num)
    payment_data_enable = PaymentData.where.not(price: 0)

    @payment_stock_price_current = []
    @stock_price_plan_current = []
    @agencies.each_with_index do |agent, i|
      @agency_id = agent.agency_id.delete('-')
      if @agency_id[3, 3] == '000'
        @payment_data_current = payment_data_enable.where('sub_order_number like ?', "#{@agency_id[0, 3]}%")
      else
        @payment_data_current = payment_data_enable.where('sub_order_number like ?', "#{@agency_id}%")
      end
      @payment_stock_price_current.push({'9800': 0, '14800': 0, '19800': 0, '27800': 0})
      @payment_data_current.each do |stock|
        @payment_stock_price_current[i].store(:"#{stock.price}", @payment_stock_price_current[i][:"#{stock.price}"] + 1)
      end
      @stock_price_plan_current.push([])
      @payment_stock_price_current[i].each do |stock_price_total|
        stock_price = plan_price_to_stock_price(stock_price_total[0].to_s.to_i)
        @stock_price_plan_current[i].push(stock_price * stock_price_total[1])
      end
    end
    start_date = params[:start_date]
    end_date = params[:end_date]
    @agenciescsv = Agency.all
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_agencies_csv(@agenciescsv, start_date, end_date)
      end
    end
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
      :email,
      :bank_name,
      :bank_code,
      :bank_branch_name,
      :bank_branch_code,
      :bank_account_type,
      :bank_account_number,
      :bank_account_holder_kana,
      :memo
    )
  end

  def plan_price_to_stock_price(price)
    if price == 9800
      2200
    elsif price == 14800
      4400
    elsif price == 19800
      6600
    elsif price == 27800
      11000
    end
  end

  def send_agencies_csv(agencies, start_date, end_date)
    tax = 1.1
    csv_data = CSV.generate do |csv|
      column_names = %w(代理店ID 代理店名 代理店TEL 代理店MAIL ライト スタンダード プレミアム 合計 金融機関名 金融機関コード 支店名 支店コード 口座種別 口座名義（カナ） 口座番号)
      csv << column_names
      agencies.each do |agency|
        if agency.parent_agency_id.eql?("parent")
          lite_plans = (Store.where('agency_charge_id like ?',"Q#{agency.agency_id[1, 2]}%").where(plan_id: 1, settlement_status: [0,2]).count  * Plan.find(1).reward_price * tax).to_i
          standard_plans = (Store.where('agency_charge_id like ?',"Q#{agency.agency_id[1, 2]}%").where(plan_id: 2, settlement_status: [0,2]).count  * Plan.find(2).reward_price * tax).to_i
          premium_plans = (Store.where('agency_charge_id like ?',"Q#{agency.agency_id[1, 2]}%").where(plan_id: 3, settlement_status: [0,2]).count  * Plan.find(3).reward_price * tax).to_i
          column_values = [
            agency.agency_id,
            "【総合】" + agency.agency_name,
            agency.agency_tel,
            agency.email,
            lite_plans,
            standard_plans,
            premium_plans,
            lite_plans + standard_plans + premium_plans,
            agency.bank_name,
            agency.bank_code,
            agency.bank_branch_name,
            agency.bank_branch_code,
            agency.bank_account_type,
            agency.bank_account_number,
            agency.bank_account_holder_kana
          ]
        elsif agency.agency_id[4,3].eql?("001")
          lite_plans = (Store.where(agency_charge_id: agency.agency_id, plan_id: 1, settlement_status: [0,2]).count  * Plan.find(1).reward_price * tax).to_i
          standard_plans = (Store.where(agency_charge_id: agency.agency_id, plan_id: 2, settlement_status: [0,2]).count  * Plan.find(2).reward_price * tax).to_i
          premium_plans = (Store.where(agency_charge_id: agency.agency_id, plan_id: 3, settlement_status: [0,2]).count  * Plan.find(3).reward_price * tax).to_i
          column_values = [
            agency.agency_id,
            agency.agency_name,
            agency.agency_tel,
            agency.email,
            lite_plans,
            standard_plans,
            premium_plans,
            lite_plans + standard_plans + premium_plans,
            agency.bank_name,
            agency.bank_code,
            agency.bank_branch_name,
            agency.bank_branch_code,
            agency.bank_account_type,
            agency.bank_account_number,
            agency.bank_account_holder_kana
          ]
        else
          lite_plans = (Store.where(agency_charge_id: agency.agency_id, plan_id: 1, settlement_status: [0,2]).count  * Plan.find(1).reward_price * tax).to_i
          standard_plans = (Store.where(agency_charge_id: agency.agency_id, plan_id: 2, settlement_status: [0,2]).count  * Plan.find(2).reward_price * tax).to_i
          premium_plans = (Store.where(agency_charge_id: agency.agency_id, plan_id: 3, settlement_status: [0,2]).count  * Plan.find(3).reward_price * tax).to_i
          column_values = [
            agency.agency_id,
            agency.agency_name,
            agency.agency_tel,
            agency.email,
            lite_plans,
            standard_plans,
            premium_plans,
            lite_plans + standard_plans + premium_plans,
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
