Rails.application.routes.draw do

  get 'friendships/new'
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  resources :friendships

  get 'my_friends', to: 'users#my_friends'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
