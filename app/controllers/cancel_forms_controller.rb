class CancelFormsController < ApplicationController
  def new
    # 入力画面を表示
    @cancel_form = CancelForm.new
  end

  def confirm
    # 入力値のチェック
    @cancel_form = CancelForm.new(cancel_form_params)
    unless @cancel_form.valid?
      render action: :new
    end
  end

  def create
    @cancel_form = CancelForm.new(cancel_form_params)
    @cancel_form.save
    NotificationMailer.cancel_form_to_user(@cancel_form).deliver
    NotificationMailer.cancel_form_to_admin(@cancel_form).deliver
    redirect_to thanks_cancel_forms_path
  end

  def thanks
  end

  private
  def cancel_form_params
    params.require(:cancel_form).permit(
      :email,
      :name,
      :tel,
      :shop_name,
      :agent_shop_name,
      :agent_charge_name,
      :plan_name,
    )
  end
end
