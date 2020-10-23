Rails.application.routes.draw do

  root 'posts#index'
  
  resources :friendships do
    match '/decline_friendship', to: 'friendships#decline_friendship', via: :post, on: :collection
    match '/accept_friendship', to: 'friendships#accept_friendship', via: :post, on: :collection
    match '/undo_friendship', to: 'friendships#undo_friendship', via: :post, on: :collection
  end

  # resources :friendships do
  #   match '/friendship-request', to: 'event_atendees#join_event', via: :post, on: :collection
  # end

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
