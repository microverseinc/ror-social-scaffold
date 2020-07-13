Rails.application.routes.draw do

  root 'posts#index'
  get '/add_friend/:friend_id', to: 'friendships#create', as: :send_request
  put '/accept_friend/:sender_id', to: 'friendships#accept', as: :accept_request
  delete '/reject_friend/:sender_id', to: 'friendships#reject', as: :reject_request
  get '/received_requests', to: 'users#invite', as: :received_requests

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
