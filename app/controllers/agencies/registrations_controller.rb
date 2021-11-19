# frozen_string_literal: true

class Agencies::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    if resource.parent_agency_id.blank?
      # 代理店テーブルの親代理店の数をカウント
      @parent_no = sprintf("%02d", Agency.where(parent_agency_id: "parent").count + 1)
      # 代理店IDを作成
      resource.agency_id = "Q#{@parent_no}-001"
      if resource.valid?
        create_parent_agency.save
        resource.parent_agency_id = "Q#{@parent_no}-000"
      end
    else
      parent_no = resource.parent_agency_id[1, 2]
      agency_no = sprintf("%03d", Agency.where('agency_id like ?',"Q#{parent_no}%").count)
      resource.agency_id = "Q#{parent_no}-#{agency_no}"
      # 親代理店IDの2桁の数値を格納（例：「Q03-000」の場合、『03』）
      # 今回が何店舗目の傘下代理店登録か、Agencyテーブルにある代理店IDをカウントし、代理店IDを作成
    end

    resource.save

    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end  
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  protected

  # create [QXX-000]
  def create_parent_agency
    Agency.create(
      password: "qrfoodjapan",
      parent_agency_id: "parent",
      agency_id: "Q#{@parent_no}-000",
      company_type: "parent",
      agency_name: "parent",
      agency_postal: "123-4567",
      agency_add: "parent",
      agency_tel: "1234567890",
      agency_rec_name: "parent",
      agency_rec_tel: "1234567890",
      agency_mail: "parent@parent.parent",
      bank_name: "parent",
      bank_code: "1234",
      bank_branch_name: "parent",
      bank_branch_code: "123",
      bank_account_type: "parent",
      bank_account_number: "1234567",
      bank_account_holder_kana: "parent"
    )
  end
  #
  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ 
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
    ])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :company_type,
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
    ])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    # super(resource)
    agencies_path
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end

  def after_sign_in_path_for(resource)
    agencies_path
  end

end
