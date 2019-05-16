Rails.application.routes.draw do
  # 認証
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    # ログイン・ログアウト
    get    'login',                 to: 'users/sessions#new'
    post   'login',                 to: 'users/sessions#create'
    delete 'logout',                to: 'users/sessions#destroy'
    # r新規登録
    get    'signup',                to: 'users/registrations#index'
    get    'signup/registration',   to: 'users/registrations#new'
  end

  # トップページ
  root 'root#index'

  # 商品
  resources :products
  
  # マイページ
  get 'mypage', to: 'mypage/mypage#index'
  get 'logout', to: 'mypage/logout#index'
  namespace :mypage do
    resources :creditcard, only: [:index, :new, :create, :destroy]
    resources :identification, only: [:edit, :update]
    resources :profiles, only: [:edit, :update]
  end
  
  # 購入
  get 'transaction', to: 'transaction/buy#index'
  namespace :transaction do
    resources :buy
  end
end
