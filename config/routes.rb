Rails.application.routes.draw do

  mount ActionCable.server => '/cable'
  
  get 'static_pages/show'
  root 'static_pages#home'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users, only: [:show] do
    member do
      get :following, :followers
    end
  end

  resources :rooms, except: [:update, :edit] do
    resource :boards, only: [:show, :create]
  end

  resources :relationships, only: [:create, :destroy]
end
