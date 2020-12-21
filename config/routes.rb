Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :users, only: %i[index show]
  resources :posts, only: %i[index create] do
    resources :comments, only: %i[create]
    resources :likes, only: %i[create destroy]
  end
  resources :friendships, only: %i[create destroy update]

  delete 'friendships/destroy_both/:id', to: 'friendships#destroy_both'
  patch 'friendships/accept_both/:id', to: 'friendships#accept_both'
end
