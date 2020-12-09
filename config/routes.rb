Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  get '/friendships/:id', to: 'friendships#update', as: 'accept_friend'
  get '/request/:id', to: 'friendships#create', as: 'friend_request'
  get '/reject/:id', to: 'friendships#destroy', as: 'reject_request'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
