class Admins::CancelListsController < AdminsController
  def index
    @q = CancelForm.ransack(params[:q])
    @cancel_lists = @q.result.order(id: :desc).page(params[:page]).per(20)
  end

  def change_treated
    @cancel_list = CancelForm.find(params[:cancel_list_id])
    respond_to do |format|
      if @cancel_list.update(treated: !(@cancel_list.treated))
        format.html { redirect_to admins_cancel_lists_path, notice: '更新しました。' }
      else
        format.html { redirect_to admins_cancel_lists_path, notice: '更新に失敗しました' }
      end
    end
  end
end
