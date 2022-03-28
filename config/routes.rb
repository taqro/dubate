Rails.application.routes.draw do
  #暫定的 debate とlike
  resources :debates do
    resource :likes, only: [:create, :destroy]
  end
  #サレンダー
  get "debates/:id/surrender" => "debates#surrender", as: 'debates_surrender'
  #投票開始
  get "debates/:id/vote_start" => "debates#vote_start", as: 'debates_vote_start'

  devise_for :users
  root 'pages#index'
  get 'users/show'
  # userとフォロー関係
  resources :users do
    member do
      #フォロー関連
      get :following, :followers
      #勝負数関連
      get :wins, :loses
    end
  end
  #フォロー関係
  resources :relationships, only: [:create, :destroy]
end
