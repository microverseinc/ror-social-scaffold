Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  resources :friendships, only: [:create, :destroy]
  post "/users/fiendships/:id/cancel", to: "friendships#cancel_friend_request", as: "cancel_friendship"
  post "/users/fiendships/:id/acept", to: "friendships#accept_friend_request", as: "acept_friendship"
  post "/users/fiendships/:id/unfriend", to: "friendships#destroy", as: "unfriend"
  post "/users/fiendships/:id/reject", to: "friendships#reject", as: "reject"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
