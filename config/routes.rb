Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  post 'friendships/create/:inviter_id/:invitee_id/:mode', to: 'friendships#create', as: 'friendship_create'
  post 'friendships/update/:inviter_id/:invitee_id', to: 'friendships#update', as: 'friendship_update'
  delete 'friendships/destroy/:inviter_id/:invitee_id/:show_user', to: 'friendships#destroy', as: 'friendship_destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
