Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  resources :users, only: [:index, :show]
  resources :friendships, only: [:index, :create, :update, :destroy]
  # resources :inverse_friendships, only: [:index, :create, :destroy]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
