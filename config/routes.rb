Rails.application.routes.draw do

  mount ActionCable.server => '/cable'
  get 'posts/create'
  get 'messages/create'

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
    resources :messages, only: :create

    resource :boards, only: [:show, :create] do
      resource :posts, only: :create
    end
  end

  resources :relationships, only: [:create, :destroy]
end
