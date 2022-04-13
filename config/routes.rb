Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  get 'conversations/create'
  get 'conversations/destroy'

  #ActionCable
  mount ActionCable.server => '/cable'

  #暫定的 debate とlike
  resources :debates do
    resource :likes, only: [:create, :destroy]
  end
  #サレンダー
  get "debates/:id/surrender" => "debates#surrender", as: 'debates_surrender'
  #投票開始
  get "debates/:id/vote_start" => "debates#vote_start", as: 'debates_vote_start'
  #議論作成者に投票する
  get "debates/:id/vote_created_user" => "debates#vote_created_user", as: 'debates_vote_created'
  #議論参加者に投票する
  get "debates/:id/vote_joined_user" => "debates#vote_joined_user", as: 'debates_vote_joined'

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
      #コメント関連
      resources :comments, only: [:create, :destroy]
    end
  end
  #フォロー関係
  resources :relationships, only: [:create, :destroy]
end
