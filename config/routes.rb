Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    resources :friendships, only: [:create, :update, :destroy]
  end

  resources :posts, only: [:index, :create], defaults: {format: 'json'} do
    resources :comments, only: [:create], defaults: {format: 'json'}
    resources :likes, only: [:create, :destroy]
  end
end