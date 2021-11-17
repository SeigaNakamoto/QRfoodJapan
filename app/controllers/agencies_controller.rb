class AgenciesController < ApplicationController
  before_action :authenticate_agency!
  before_action :set_agency


  def index
    # 【今月】
    # ストック型（件数、報酬合計）、スポット型（件数、報酬合計）
    @st_cnt, @st_total, @sp_cnt, @sp_total = 0, 0, 0, 0
      @plans.each do |p|
        reward_cnt = Store.where(agency_id: @agency.agency_id, plan_id: p.id, settlement_status: [0,2]).count # プラン毎の合計件数格納
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
        reward_cnt = Store.where(agency_id: @agency.agency_id, plan_id: p.id, settlement_status: [0,2], created_at: Date.current.strftime('%Y-%m-%d').in_time_zone.all_month).count # プラン毎の合計件数格納
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
  
  def projects
    @agencies = Agency.page(params[:page])
  end
  
  def store_list
    @companies = Company.joins(:stores).where(stores: { agency_id: @agency.agency_id}).page(params[:page]).per(30)
    @companiescsv = Company.joins(:stores).where(stores: { agency_id: @agency.agency_id}).all
    # CSV出力
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_companies_csv(@companiescsv)
      end
    end
  end
  
  def agency_list
    @agencies = Agency.where(parent_agency_id: @agency.parent_agency_id).page(params[:page]).per(30)
    @special_reward = (@special_reward_cnt * 2000 * @tax).to_i
  end
  
  private
  
  def set_agency
    @agency = current_agency
    @plans = Plan.all
    @tax = 1.1
    # 傘下代理店一覧
    @child_agencies = Agency.where(parent_agency_id: @agency.parent_agency_id)
    # 【今月】特別代理店報酬対象件数
    @special_reward_cnt = 0
      @child_agencies.each do |child|
        @special_reward_cnt += Store.where(agency_id: child.agency_id, settlement_status: [0,2]).count
      end
    # 【当月】特別代理店報酬対象件数
    @special_reward_cnt_m = 0
      @child_agencies.each do |child|
        @special_reward_cnt_m += Store.where(agency_id: child.agency_id, settlement_status: [0,2], created_at: Date.current.strftime('%Y-%m-%d').in_time_zone.all_month).count
      end
  end

  def send_companies_csv(companies)
    csv_data = CSV.generate do |csv|
      column_names = %w(店舗ID お申込者名 店舗名 店舗TEL 店舗MAIL 進捗ステータス 決済ステータス)
      csv << column_names
      companies.each do |c|
        c.stores.each do |s|
          column_values = [
            c.id,
            s.per_name,
            s.store_name,
            s.store_tel,
            s.store_email,
            s.progress_status_i18n,
            s.settlement_status_i18n
          ]
          csv << column_values
        end
      end
    end
    send_data(csv_data, filename: "代理店側_ユーザー一覧.csv")
  end

end
