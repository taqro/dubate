Rails.application.routes.draw do
  #暫定的 debate
  resources :debates

  devise_for :users
  root 'pages#index'
  get 'pages/show'
  # userとフォロー関係
  resources :users do
    member do
      get :following, :followers
    end
  end
  #フォロー関係
  resources :relationships, only: [:create, :destroy]
end
