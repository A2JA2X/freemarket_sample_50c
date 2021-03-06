Rails.application.routes.draw do
  # 認証
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    # ログイン・ログアウト
    get    'login',                 to: 'users/sessions#new'
    post   'login',                 to: 'users/sessions#create'
    delete 'logout',                to: 'users/sessions#destroy'
    # 新規登録
    get    'signup',                to: 'users/registrations#index'
    get    'signup/registration',   to: 'users/registrations#new'
  end

  # トップページ
  root     'root#index'

  # 商品
  resources :products
  resources :comments, only: [:create]
  post      'search',               to: 'products#search'
  post      'stop_sell',            to: 'products#stop_selling'
  # マイページ
  get      'mypage',                to: 'mypage/mypage#index'
  get      'logout',                to: 'mypage/logout#index'

  namespace :mypage do
  #クレジットカード 
    resources :creditcard, only: [:index, :new] do
      collection do
        post 'pay', to: 'creditcard#pay'
        post 'delete', to: 'creditcard#delete'
      end
    end
    get    'profile',               to: 'profiles#edit'
    patch  'profile',               to: 'profiles#update'
    get    'identification',        to: 'identification#edit'
    patch  'identification',        to: 'identification#update'
    get    'listings/listing',      to: 'listings#listing'
    get    'listings/in_progress',      to: 'listings#in_progress'
    get    'listings/completed',      to: 'listings#completed'
  end

  # 購入
  namespace :transaction do
    resources :buy, only: [:show, :create]
  end
end
