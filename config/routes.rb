Rails.application.routes.draw do
  root 'posts#index'
  get 'friendships/create'
  # code from lastnight
  get 'my_friends', to: 'users#my_friends'
  get 'requests', to: 'users#requests'
  



  devise_for :users

  resources :users, only: [:index, :show]
  resources :friendships, only: [:new, :create, :update, :destroy]
  
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
