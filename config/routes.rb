Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index, :create]
    end 
  end

  post 'friendships/create'
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    member do 
      post :confirm
      delete :destroy
    end
  end
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
