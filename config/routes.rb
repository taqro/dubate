Rails.application.routes.draw do
  #暫定的 debate
  get 'debates/index'
  get 'debates/show'
  get 'debates/new'
  get 'debates/create'
  get 'debates/destroy'
  get 'debates/edit'

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
