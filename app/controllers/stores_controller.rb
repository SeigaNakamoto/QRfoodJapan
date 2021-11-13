class StoresController < ApplicationController
  before_action :set_plans, only: %i[new create edit]

  def index
      @companies = Company.joins(:stores).all
  end

  def new
  end

  def create
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
  end

    private
  
  def set_plans
    @plans = Plan.all
  end
  
  def set_target_store
    @company = Company.find(params[:id])
  end
  
end