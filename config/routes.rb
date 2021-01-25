Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  get 'friend_invite/:id', to: 'users#friend_invite', as: :friend_invite
  get 'confirm_request/:id', to: 'users#confirm_request', as: :confirm_request
  get 'reject_friendship/:id', to: 'users#reject_friendship', as: :reject_friendship
  get 'pending_friends', to: 'users#pending_friends', as: :pending_friends

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
