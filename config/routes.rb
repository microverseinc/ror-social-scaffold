Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    get :create_friend, to:'users#create_friend', as: 'create_friend'
    get :create_friend_request, to:'users#create_friend_request', as: 'create_friend_request'
    get :reject_friend_request, to:'users#reject_friend_request', as: 'reject_friend_request'
    get :unfriend, to:'users#unfriend', as: 'unfriend'
  end
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
