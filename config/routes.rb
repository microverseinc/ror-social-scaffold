Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
      resources :comments, only: [:create]
      resources :likes, only: [:create, :destroy]
    end
  resources :invitations, only:[:create, :destroy, :update]
end
