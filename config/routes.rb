Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
  resources :friendships, only: [:index]
    member do
      put 'add_friend', to: 'users#add_friend'
      post 'request_friendship', to: 'friendships#create'
      delete 'unfriend', to: 'friendships#destroy'
    end
  end  
    resources :posts, only: [:index, :create] do
      resources :comments, only: [:create]
      resources :likes, only: [:create, :destroy]
    end
end