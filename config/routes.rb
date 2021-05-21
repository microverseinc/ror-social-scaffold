Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users do
    member do
      get :friends
    end
  end

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  resources :friendships, only:[:create,:destroy]
end
