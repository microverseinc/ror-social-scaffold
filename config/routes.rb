Rails.application.routes.draw do
  root 'posts#index'
  post 'invite', to: 'friendships#create'
  put 'invite', to: 'users#update'
  delete 'reject', to: 'users#destroy'
  devise_for :users
  resources :users, only: [:index, :show] do
    resources :friendships
  end
  resources :posts, only: [:index, :show, :create] do
    resources :comments, only: [:index, :create]
    resources :likes, only: [:create, :destroy]
  end
end