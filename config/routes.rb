Rails.application.routes.draw do

  root 'posts#index'
  devise_for :users

  resources :users, only: %i[index show]
  resources :posts, only: %i[index create] do
    resources :comments, only: [:create]
    resources :likes, only: %i[create destroy]
  end
  resources :friendships, only: %i[create update], controller: 'friendships'
  delete '/friendships/:id' => 'friendships#destroy', as: :destroy_friendship

end
