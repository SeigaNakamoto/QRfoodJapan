class AgenciesController < ApplicationController
  before_action :authenticate_agency!, only: %i[index projects store_list agency_list]
  before_action :set_agency


  def index
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
    
  end
  
  def edit
    @agency = Agency.find(params[:id])
  end
  
  def update
    if current_agency.update(agency_params)
      flash[:notice] = "「#{current_agency.agency_name}」の代理店情報を変更しました。"
      redirect_to edit_agency_registration_path(current_agency)
    end
  end
  
  def projects
    @agencies = Agency.page(params[:page])
  end
  
  def store_list
    @companies = Company.joins(:stores).where(stores: { agency_id: @agency.agency_id}).page(params[:page]).per(30)
    
    # CSV出力
    @companiescsv = Company.joins(:stores).where(stores: { agency_id: @agency.agency_id}).all
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_companies_csv(@companiescsv)
      end
    end
  end
  
  def agency_list
    @agencies = Agency.where(parent_agency_id: @agency.agency_id).page(params[:page]).per(30)
    @special_reward = (@special_reward_cnt * 2000 * @tax).to_i
  end
  
  private
  
  def set_agency
    @agency = current_agency
    @plans = Plan.all
    @tax = 1.1
    # 傘下代理店一覧
    @child_agencies = Agency.where(parent_agency_id: @agency.agency_id)
    @special_reward_cnt = 0 # 特別代理店報酬対象件数
      @child_agencies.each do |child|
        @special_reward_cnt += Store.where(agency_id: child.agency_id, settlement_status: [0,2]).count
      end
  end
  
  def agency_params
    params.require(:agency).permit(
      :company_type,
      :parent_agency_id,
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

  def send_companies_csv(companies)
    csv_data = CSV.generate do |csv|
      column_names = %w(店舗ID お申込者名 店舗名 店舗TEL 店舗MAIL 進捗ステータス 決済ステータス)
      csv << column_names
      companies.each do |c|
        progress_name, settlement_name = "", ""
        @progresses.each do |p|
          if p.id.eql?(c.stores.map(&:progress_id)[0])
            progress_name = p.name
          end
        end
        @settlements.each do |s|
          if s.id.eql?(c.stores.map(&:settlement_id)[0])
            settlement_name = s.name
          end
        end
        column_values = [
          c.id,
          c.stores.map(&:per_name)[0],
          c.stores.map(&:store_name)[0],
          c.stores.map(&:store_tel)[0],
          c.stores.map(&:store_email)[0],
          progress_name,
          settlement_name
        ]
        csv << column_values
      end
    end
    send_data(csv_data, filename: "代理店側_ユーザー一覧.csv")
  end

end
