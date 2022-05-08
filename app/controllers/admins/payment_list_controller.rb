class Admins::PaymentListController < ApplicationController
  before_action :authenticate_admin!
  require 'csv'

  def index
    @payment_data_list = PaymentData.order("payment_date DESC").page(params[:page]).per(10)
    # @q = Agency.ransack(params[:q])
    # @agencies = @q.result.includes(:user).page(params[:page]).order("created_at desc")
  end

  def import
    PaymentData.import(params[:file])
    redirect_to admins_payment_list_index_path
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
end
