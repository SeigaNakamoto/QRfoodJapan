class AgenciesController < ApplicationController
  before_action :authenticate_agency!
  before_action :set_agency
  require 'csv'

  def index
    # 【今月】
    # ストック型（件数、報酬合計）、スポット型（件数、報酬合計）
    @st_cnt, @st_total, @sp_cnt, @sp_total = 0, 0, 0, 0
    @plans.each do |p|
      reward_cnt = Store.where(agency_charge_id: @agency.agency_id, plan_id: p.id, settlement_status: [0,2]).count # プラン毎の合計件数格納
      reward_price = (reward_cnt * p.reward_price * @tax).to_i # プラン毎の報酬金額格納
      if p.reward_style.eql?('ストック型（毎月）')
        @st_cnt += reward_cnt
        @st_total += reward_price
      else
        @sp_cnt += reward_cnt
        @sp_total += reward_price
      end
    end
    # 特別代理店報酬金額
    @special_reward = (@special_reward_cnt * 2000 * @tax).to_i

    # 【当月】
    # ストック型（件数、報酬合計）、スポット型（件数、報酬合計）
    @st_cnt_m, @st_total_m, @sp_cnt_m, @sp_total_m = 0, 0, 0, 0
    @plans.each do |p|
      reward_cnt = Store.where(agency_charge_id: @agency.agency_id, plan_id: p.id, settlement_status: [0,2], created_at: Date.current.strftime('%Y-%m-%d').in_time_zone.all_month).count # プラン毎の合計件数格納
      reward_price = (reward_cnt * p.reward_price * @tax).to_i # プラン毎の報酬金額格納
      if p.reward_style.eql?('ストック型（毎月）')
        @st_cnt_m += reward_cnt
        @st_total_m += reward_price
      else
        @sp_cnt_m += reward_cnt
        @sp_total_m += reward_price
      end
    end
    # 特別代理店報酬金額
    @special_reward_m = (@special_reward_cnt_m * 2000 * @tax).to_i
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
    @special_reward = (@special_reward_cnt * 2000 * @tax).to_i
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
    @plans = Plan.all
    @tax = 1.1

    # 傘下代理店一覧
    @child_agencies = Agency.where(parent_agency_id: @agency.parent_agency_id)

    # 【今月/当月】特別代理店報酬対象件数
    @special_reward_cnt, @special_reward_cnt_m = 0, 0
    # 【今月/当月】累計代理店報酬
    @child_agencies_reward, @child_agencies_reward_m = 0, 0

    if @agency.agency_id[4,3].eql?('001')
      @child_agencies.each do |child|
        @special_reward_cnt += Store.where(agency_charge_id: child.agency_id, settlement_status: [0,2]).count
        @special_reward_cnt_m += Store.where(agency_charge_id: child.agency_id, settlement_status: [0,2], created_at: Date.current.strftime('%Y-%m-%d').in_time_zone.all_month).count
      end
      @agencies.each do |a|
        @plans.each do |p|
          @child_agencies_reward += (Store.where(agency_charge_id: a.agency_id, plan_id: p.id, settlement_status: [0,2]).count * p.reward_price * @tax).to_i
          @child_agencies_reward_m += (Store.where(agency_charge_id: a.agency_id, plan_id: p.id, settlement_status: [0,2], created_at: Date.current.strftime('%Y-%m-%d').in_time_zone.all_month).count * p.reward_price * @tax).to_i
        end
      end
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
