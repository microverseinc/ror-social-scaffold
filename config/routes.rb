Rails.application.routes.draw do

  get 'frienships/index'
  root 'posts#index'

  devise_for :users

  resources :friendships, only: [:index,:create,:destroy] do
    member do
      put :confirm
    end
  end

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
