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

  # 運営側システム
  get "admins/agencies" => "admins#agencies"
  get "admins/stores" => "admins#stores"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # 追加ルーティング
  # 代理店
  get  "agencies/projects"  => "agencies#projects"
  get  "agencies/store_list"  => "agencies#store_list"
  get  "agencies/agency_list"  => "agencies#agency_list"
  get  "agencies/payment"  => "agencies#payment"
  
  # QRfoodサービスお申込フォーム
  resources :users, module: 'agencies', only: [:new, :create]
  get  "users/payment"  => "agencies/users#payment"
  get  "users/termsofservice" => "agencies/users#termsofservice"
  get  "users/privacypolicy" => "agencies/users#privacypolicy"
  

  # 利用規約

  
  root to: 'home#index'
  resources :companies
  resources :agencies
  resources :admins
  resources :stores do
    resource :progress_status, only: :update, controller: 'stores/progress_status'
    resource :settlement_status, only: :update, controller: 'stores/settlement_status'
  end

end