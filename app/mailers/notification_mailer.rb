class NotificationMailer < ActionMailer::Base
  default from: 'qrfoodjapan00@gmail.com'
  layout 'mailer'

  # ========================================================================
  # 店舗申し込み時の自動返信メール

  # ---------
  # 店舗
  def registrer_to_store(company, store, plan)
    @company = company
    @store = store
    @plan = plan

    mail(to: @store.per_email,
         cc: @company.rep_email,
          subject: "【QRFoodJapan】申し込みが完了しました")
  end
  # ---------------------------

  # ---------
  # 代理店
  def registrer_to_agent(company, store, plan)
    @company = company
    @store = store
    @plan = plan

    mail(to: @store.agency.email,
          subject: "【QRFoodJapan】店舗申し込みが完了しました")
  end
  # ---------------------------

  # ---------
  # 運営管理
  def registrer_to_admin(company, store, plan)
    @company = company
    @store = store
    @plan = plan

    mail(to: 'qrfoodjapan00@gmail.com',
          subject: "【QRFoodJapan】店舗申し込みが完了されました")
  end
  # ---------------------------
  # ========================================================================

  # ========================================================================
  # 解約申請時の自動返信メール

  # ---------
  # 店舗
  def cancel_form_to_user(form)
    @form = form

    mail(to: @form.email,
          subject: "【QRFoodJapan】店舗解約申請が完了しました")
  end
  # ---------------------------

  # ---------
  # 運営管理
  def cancel_form_to_admin(form)
    @form = form

    mail(to: 'qrfoodjapan00@gmail.com',
          subject: "【QRFoodJapan】店舗解約申請されました")
  end
  # ---------------------------
  # ========================================================================

end
