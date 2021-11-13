class RemoveColumnsFromCompanies < ActiveRecord::Migration[6.1]
  def change
    remove_columns :companies, :company_id, :company_code,  :password_digest
  end
end
