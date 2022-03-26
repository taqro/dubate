Rails.application.routes.draw do
  #暫定的 debate とlike
  resources :debates do
    resource :likes, only: [:create, :destroy]
    get "surrender" => "debates#surrender"
  end

  get "debates/:id/surrender" => "debates#surrender", as: 'debates_surrender'

  devise_for :users
  root 'pages#index'
  get 'users/show'
  # userとフォロー関係
  resources :users do
    member do
      get :following, :followers
    end
  end
  #フォロー関係
  resources :relationships, only: [:create, :destroy]
end
