Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  get 'send_friend_request', to: 'friendships#send_invitation'
  get 'accept_friend_request', to: 'friendships#confirm_request'
  delete 'deny_friend_request', to: 'friendships#reject_request'
  get 'friends', to: 'friendships#all_friends'
  delete 'unfriend', to: 'friendships#unfriend'






end
