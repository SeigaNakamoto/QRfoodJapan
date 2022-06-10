class NotificationMailer < ActionMailer::Base
  default from: 'from@example.com'
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

    mail(to: 'from@example.com',
          subject: "【QRFoodJapan】店舗申し込みが完了されました")
  end
  # ---------------------------
  # ========================================================================

end
