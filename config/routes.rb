Rails.application.routes.draw do
  get 'friendship_invitations', to: 'friendship_invitations#index', as: 'invitations'
  post 'friendship_invitations/create', as: 'send_invitation'
  post 'friendship_invitations/update', to: 'friendship_invitations#update', as: 'confirm_invitation'
  get 'friendship_invitations/destroy'
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
