Rails.application.routes.draw do
  # 管理者ログイン関連
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  #　代理店ログイン関連
  devise_for :agencies, controllers: {
    sessions:      'agencies/sessions',
    passwords:     'agencies/passwords',
    registrations: 'agencies/registrations'
  }

  # メールの送受信確認
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # 追加ルーティング

  # 運営側システム
  namespace :admins do
    resources :user_list, :agency_list
    resources :payment_list do
      collection {post :import}
    end
  end

  get "admins/store_list" => "admins#store_list"
  get "admins/agency_list" => "admins#agency_list"


  # 代理店側システム
  get  "agencies/projects"  => "agencies#projects"
  get  "agencies/store_list"  => "agencies#store_list"
  get  "agencies/agency_list"  => "agencies#agency_list"
  get  "agencies/payment"  => "agencies#payment"
  get  "agencies/paid"  => "agencies#paid"
  
  # QRfoodサービスお申込フォーム
  resources :users, module: 'agencies', only: [:new, :create]
  get  "users/entry_payment"  => "agencies/users#entry_payment"
  get  "users/light_payment"  => "agencies/users#light_payment"
  get  "users/standard_payment"  => "agencies/users#standard_payment"
  get  "users/premium_payment"  => "agencies/users#premium_payment"
  get  "users/paid"  => "agencies/users#paid"
  get  "users/univapay" => "agencies/users#univapay"
  get  "users/termsofservice" => "agencies/users#termsofservice"
  get  "users/privacypolicy" => "agencies/users#privacypolicy"
  
  resources :companies
  resources :agencies
  resources :stores do
    resource :progress_status, only: :update, controller: 'stores/progress_status'
    resource :settlement_status, only: :update, controller: 'stores/settlement_status'
  end

end