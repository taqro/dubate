Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  get 'pages/show'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end
