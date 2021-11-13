# frozen_string_literal: true

class Agencies::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [
      :parent_agency_id,
      :company_type,
      :agency_name,
      :agency_postal,
      :agency_add,
      :agency_add_kana,
      :agency_tel,
      :agency_fax,
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

  def after_sign_in_path_for(resource)
    agencies_path
  end

  def after_sign_out_path_for(resource)
    new_agency_session_path
  end
end
