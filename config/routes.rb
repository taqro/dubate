Rails.application.routes.draw do

  get 'boards/show'
  get 'static_pages/show'
  get 'users/show'
  root 'static_pages#home'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users, only: [:show]

  resources :rooms, except: [:update, :edit]
end
