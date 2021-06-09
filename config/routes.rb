Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index,   :show]

  resources :friendships, only: [ :update, :destroy] 
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #match '/users/:user_id/friendships', to: 'users#index', via: :get
  #match '/friendships/:id', to: 'users#index', via: :get
 
  post 'users/:id/friendship', to: 'friendships#create' , as: :create_friendship
  
end
