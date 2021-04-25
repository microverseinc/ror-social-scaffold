Rails.application.routes.draw do
  resources :friendships
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  get 'update/request', to: 'friendships#accept_or_reject_friend_request'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

  

  