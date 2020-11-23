Rails.application.routes.draw do

  get 'static_pages/show'
  # get 'users/show'
  root 'static_pages#home'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users, only: [:show]

  resources :rooms, except: [:update, :edit] do
    resource :boards, only: [:show, :create]
  end
end
