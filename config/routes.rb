Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  post '/friendships/update/:id', to: 'friendships#update', as: 'friend'
  post '/friendships/create/:id', to: 'friendships#create', as: 'create_friend'
  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
