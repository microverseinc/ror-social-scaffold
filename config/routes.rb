Rails.application.routes.draw do

  get 'friendships/index'
  get 'friendships/create'
  get 'friendships/destroy'
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    post 'accept', to:'users/accept', as: 'accept'
    delete 'reject', to:'users/reject', as: 'reject'
    post 'invite', to:'users/invite', as: 'invite'    
    delete 'cancel', to:'users/cancel', as: 'cancel'
    delete 'remove', to:'users/cancel', as: 'remove'
  end
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  resources :friendships

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
