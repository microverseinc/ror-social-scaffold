Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users
  resources :users, only: %i[index show] do
    member do
      get :friends
    end
  end

  get 'friends', to: 'friendships#index', as: 'friends'
  post 'friends/create/:id', to: 'friendships#create', as: 'add_friend'
  put 'friends/accept.:id', to: 'friendships#accept', as: 'accept_request'
  delete 'friends/decline/:id', to: 'friendships#decline', as: 'decline_request'
  delete 'friends/delete/:id', to: 'friendships#destroy', as: 'delete_friend'

  resources :posts, only: %i[index create] do
    resources :comments, only: [:create]
    resources :likes, only: %i[create destroy]
  end
end
