class Stores::SettlementStatusController < ApplicationController
  before_action :set_store, :update_settlement_status, only: :update

  def update
    respond_to do |format|
      format.json { render json: {store_name: @store.store_name, settlement_status: @store.settlement_status} }
    end
  end
  
  private
  
  def set_store
    @store = Store.find(params[:store][:id])
  end
  
  def update_settlement_status
    case params[:store][:settlement_status]
    when "no_problem"
      @store.settlement_no_problem!
    when "delinquent"
      @store.settlement_delinquent!
    when "cancellation_reservation"
      @store.settlement_cancellation_reservation!
    when "canceled"
      @store.settlement_canceled!
    end
  end

end
