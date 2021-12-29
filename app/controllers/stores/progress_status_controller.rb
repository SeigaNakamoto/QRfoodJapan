class Stores::ProgressStatusController < ApplicationController
  before_action :set_store, :update_progress_status, only: :update

  def update
    respond_to do |format|
      format.json { render json: {store_name: @store.store_name, progress_status: @store.progress_status_i18n} }
    end
  end
  
  private
  
  def set_store
    @store = Store.find(params[:store][:id])
  end
  
  def update_progress_status
    case params[:store][:progress_status]
    when "photo_waiting"
      @store.progress_photo_waiting!
    when "univapay_waiting"
      @store.progress_univapay_waiting!
    when "no_problem"
      @store.progress_no_problem!
    end
  end

end
