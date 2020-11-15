Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] 
  resources :friendshipps 

  put 'accept_friend', to: 'friendshipps#accept'
  delete 'decline_request', to: 'friendshipps#reject'

  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
end
