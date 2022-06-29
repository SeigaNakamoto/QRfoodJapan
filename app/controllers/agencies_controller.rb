class AgenciesController < ApplicationController
  before_action :authenticate_agency!
  before_action :set_agency
  before_action :new_set_agency, only: [:index]
  require 'csv'

  def index
    # 【今月】
    # ストック型（件数、報酬合計）、スポット型（件数、報酬合計）
    # @st_cnt, @st_total, @sp_cnt, @sp_total = 0, 0, 0, 0
    # @plans.each do |p|
    #   reward_cnt = Store.where(agency_charge_id: @agency.agency_id, plan_id: p.id, settlement_status: [0,2]).count # プラン毎の合計件数格納
    #   reward_price = (reward_cnt * p.reward_price * @tax).to_i # プラン毎の報酬金額格納
    #   if p.reward_style.eql?('ストック型（毎月）')
    #     @st_cnt += reward_cnt
    #     @st_total += reward_price
    #   else
    #     @sp_cnt += reward_cnt
    #     @sp_total += reward_price
    #   end
    # end
    # # 特別代理店報酬金額
    # @special_reward = (@special_reward_cnt * 2000 * @tax).to_i

    # # 【当月】
    # # ストック型（件数、報酬合計）、スポット型（件数、報酬合計）
    # @st_cnt_m, @st_total_m, @sp_cnt_m, @sp_total_m = 0, 0, 0, 0
    # @plans.each do |p|
    #   reward_cnt = Store.where(agency_charge_id: @agency.agency_id, plan_id: p.id, settlement_status: [0,2], created_at: Date.current.strftime('%Y-%m-%d').in_time_zone.all_month).count # プラン毎の合計件数格納
    #   reward_price = (reward_cnt * p.reward_price * @tax).to_i # プラン毎の報酬金額格納
    #   if p.reward_style.eql?('ストック型（毎月）')
    #     @st_cnt_m += reward_cnt
    #     @st_total_m += reward_price
    #   else
    #     @sp_cnt_m += reward_cnt
    #     @sp_total_m += reward_price
    #   end
    # end
    # # 特別代理店報酬金額
    # @special_reward_m = (@special_reward_cnt_m * 2000 * @tax).to_i
  end

  def update
    @agency = Agency.find(params[:id])
    if @agency.update(agency_params)
      flash[:success] = "「#{@agency.agency_name}」の代理店情報を変更しました。"
      redirect_to agency_path(@agency.id)
    else
      render 'show'
    end
  end

  def projects
    @agencies = Agency.page(params[:page])
    # 全て
    payment_data_enable = PaymentData.where.not(price: 0)
    @agency_id = current_agency.agency_id.delete('-')
    @payment_data_current = payment_data_enable.where('sub_order_number like ?', "#{@agency_id}%")
    @payment_stock_price_current = {'9800': 0, '14800': 0, '19800': 0, '27800': 0}
    @payment_data_current.each do |stock|
      @payment_stock_price_current.store(:"#{stock.price}", @payment_stock_price_current[:"#{stock.price}"] + 1)
    end
    @stock_price_plan_current = []
    @payment_stock_price_current.each do |stock_price_total|
      stock_price = plan_price_to_stock_price(stock_price_total[0].to_s.to_i)
      @stock_price_plan_current.push(stock_price * stock_price_total[1])
    end
  end

  def store_list
    @companies = Company.order(id: :desc).joins(:stores).where(stores: { agency_charge_id: @agency.agency_id}).page(params[:page]).per(30)
    if params[:export_csv]
      @start_date = params[:start_date]
      @end_date = params[:end_date]
      if @start_date.blank? || @end_date.blank?
        @companiescsv = Company.joins(:stores).where(stores: { agency_charge_id: @agency.agency_id})
      else
        @companiescsv = Company.joins(:stores).where(stores: { agency_charge_id: @agency.agency_id}).where(stores: {created_at: @start_date..@end_date})
      end
    end
    # CSV出力
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_companies_csv(@companiescsv)
      end
    end
  end

  def agency_list
    payment_data_enable = PaymentData.where.not(price: 0)
    @special_price_count = 0
    tax = 1.1
    special_price = 2000

    @payment_stock_price_current = []
    @stock_price_plan_current = []
    @agencies.each_with_index do |agent, i|
      @agency_id = agent.agency_id.delete('-')
      @payment_data_current = payment_data_enable.where('sub_order_number like ?', "#{@agency_id}%")
      @payment_stock_price_current.push({'9800': 0, '14800': 0, '19800': 0, '27800': 0})
      @payment_data_current.each do |stock|
        @payment_stock_price_current[i].store(:"#{stock.price}", @payment_stock_price_current[i][:"#{stock.price}"] + 1)
        @special_price_count += 1 unless @agency_id[3, 3] == '001'
      end
      @stock_price_plan_current.push([])
      @payment_stock_price_current[i].each do |stock_price_total|
        stock_price = plan_price_to_stock_price(stock_price_total[0].to_s.to_i)
        @stock_price_plan_current[i].push(stock_price * stock_price_total[1])
      end
    end
    @special_price = (@special_price_count * special_price * tax).to_i
    start_date = params[:start_date]
    end_date = params[:end_date]
    respond_to do |format|
      format.html
      format.csv do |csv|
        agency_list_csv(@child_agencies, start_date, end_date)
      end
    end
  end

  def paid
    @param = request.query_string
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
      :bank_account_holder_kana
    )
  end

  def set_agency
    @agency = current_agency
    @agencies = Agency.where(parent_agency_id: @agency.parent_agency_id).page(params[:page]).per(30)
    @plans = Plan.order(:order_num)
    @tax = 1.1

    # # 傘下代理店一覧
    @child_agencies = Agency.where(parent_agency_id: @agency.parent_agency_id)
  end

  def new_set_agency
    @agency_id = current_agency.agency_id.delete('-')
    @agency_id_head = @agency_id.slice(0,3)
    @agency_id_foot = @agency_id.slice(3,3)
    tax = 1.1
    special_price = 2000
    this_month = Date.today.all_month

    # 支払い単価が０円のものは、報酬の対象外となるので省いている
    payment_data_enable = PaymentData.where.not(price: 0)

    # 全ての期間のデータ(上から「親＋子」「親」「子」)
    @payment_data_all = payment_data_enable.where('sub_order_number like ?', "#{@agency_id_head}%")
    @payment_data_current = payment_data_enable.where('sub_order_number like ?', "#{@agency_id}%")
    @payment_data_child = @payment_data_all - @payment_data_current

    # 当月のデータ(上から「親＋子」「親」「子」)
    @payment_data_all_month = @payment_data_all.where(payment_date: this_month)
    @payment_data_current_month = @payment_data_current.where(payment_date: this_month)
    @payment_data_child_month = @payment_data_all_month - @payment_data_current_month

    # 報酬が発生する数
    @payment_data_all_count = @payment_data_all.count
    @payment_data_all_count_month = @payment_data_all_month.count
    @payment_data_current_count = @payment_data_current.count
    @payment_data_current_count_month = @payment_data_current_month.count
    @payment_data_child_count = @payment_data_child.count
    @payment_data_child_count_month = @payment_data_child_month.count

    # 報酬形態内訳
    # 全て
    @payment_stock_price_current = {'9800': 0, '14800': 0, '19800': 0, '27800': 0}
    @payment_data_current.each do |stock|
      @payment_stock_price_current.store(:"#{stock.price}", @payment_stock_price_current[:"#{stock.price}"] + 1)
    end
    @stock_price_plan_current = []
    @payment_stock_price_current.each do |stock_price_total|
      stock_price = plan_price_to_stock_price(stock_price_total[0].to_s.to_i)
      @stock_price_plan_current.push(stock_price * stock_price_total[1])
    end
    # 月
    @payment_stock_price_current_month = {'9800': 0, '14800': 0, '19800': 0, '27800': 0}
    @payment_data_current_month.each do |stock|
      @payment_stock_price_current_month.store(:"#{stock.price}", @payment_stock_price_current_month[:"#{stock.price}"] + 1)
    end
    @stock_price_plan_current_month = []
    @payment_stock_price_current_month.each do |stock_price_total|
      stock_price = plan_price_to_stock_price(stock_price_total[0].to_s.to_i)
      @stock_price_plan_current_month.push(stock_price * stock_price_total[1])
    end

    # 親のみが表示する項目
    if @agency_id_foot == '001'

      # 報酬形態内訳(子)
      # 全ての期間
      @payment_stock_price_child = {'9800': 0, '14800': 0, '19800': 0, '27800': 0}
      @payment_data_child.each do |stock|
        @payment_stock_price_child.store(:"#{stock.price}", @payment_stock_price_child[:"#{stock.price}"] + 1)
      end
      @stock_price_plan_child = []
      @payment_stock_price_child.each do |stock_price_total|
        stock_price = plan_price_to_stock_price(stock_price_total[0].to_s.to_i)
        @stock_price_plan_child.push(stock_price * stock_price_total[1])
      end

      # 月
      @payment_stock_price_child_month = {'9800': 0, '14800': 0, '19800': 0, '27800': 0}
      @payment_data_child_month.each do |stock|
        @payment_stock_price_child_month.store(:"#{stock.price}", @payment_stock_price_child_month[:"#{stock.price}"] + 1)
      end
      @stock_price_plan_child_month = []
      @payment_stock_price_child_month.each do |stock_price_total|
        stock_price = plan_price_to_stock_price(stock_price_total[0].to_s.to_i)
        @stock_price_plan_child_month.push(stock_price * stock_price_total[1])
      end

      # 特別代理店管理料詳細
      @payment_special_price = (@payment_data_child_count * special_price * tax).to_i
      @payment_special_price_month = (@payment_data_child_count_month * special_price * tax).to_i
    end

    # 現在の報酬詳細
    @total_price = @stock_price_plan_current.sum + @payment_special_price.to_i
    @total_price_month = @stock_price_plan_current_month.sum + @payment_special_price_month.to_i
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

  def send_companies_csv(companies)
    tax = 1.1
    csv_data = CSV.generate do |csv|
      column_names = %w(店舗ID お申込者名 店舗名 プラン名 店舗TEL 店舗MAIL 進捗ステータス 決済ステータス 報酬金額(税込))
      csv << column_names
      companies.each do |c|
        c.stores.each do |s|
          column_values = [
            c.id,
            s.per_name,
            s.store_name,
            Plan.where(id: s.plan_id).first.name,
            s.store_tel,
            s.store_email,
            s.progress_status_i18n,
            s.settlement_status_i18n,
            (s.plan.reward_price * tax).to_i
          ]
          csv << column_values
        end
      end
    end
    send_data(csv_data, filename: "代理店側_ユーザー一覧.csv")
  end

  def agency_list_csv(child_agencies, start_date, end_date)
    tax = 1.1
    csv_data = CSV.generate do |csv|
      column_names = %w(代理店ID 代理店名 代理店TEL 代理店MAIL ライトプランの報酬合計 スタンダードプラン報酬合計 プレミアムプラン報酬合計 報酬金額合計)
      csv << column_names
      child_agencies.each do |child_agency|
        lite_plans = (Store.where(agency_charge_id: child_agency.agency_id, plan_id: 1, settlement_status: [0,2], created_at: start_date..end_date).count * Plan.find(1).reward_price * tax).to_i
        standard_plans = (Store.where(agency_charge_id: child_agency.agency_id, plan_id: 2, settlement_status: [0,2], created_at: start_date..end_date).count * Plan.find(2).reward_price * tax).to_i
        premium_plans = (Store.where(agency_charge_id: child_agency.agency_id, plan_id: 3, settlement_status: [0,2], created_at: start_date..end_date).count * Plan.find(3).reward_price * tax).to_i
        column_values = [
          child_agency.agency_id,
          child_agency.company_type == '法人' ? child_agency.agency_name : "＜個人＞#{a.agency_rec_name}",
          child_agency.agency_tel,
          child_agency.email,
          lite_plans,
          standard_plans,
          premium_plans,
          lite_plans + standard_plans + premium_plans,
        ]
        csv << column_values
      end
    end
    send_data(csv_data, filename: "子代理店情報.csv")
  end
end
