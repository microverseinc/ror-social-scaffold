Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users


  get '/send_request/:id' , to: 'friendships#send_request',as: "send_request"
  get '/accept_friend/:id', to: 'friendships#accept_friend',as: "accept_friend"
  get '/destroy_friendship/:id', to: 'friendships#destroy_friendship', as: "destroy_friendship"

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
