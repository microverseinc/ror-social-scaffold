Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :users, only: %i[index show]
  post '/index/:id', to: 'users#add_friend', as: 'add_friend'
  # post '/index/:id', to: 'users#add_friend', as: 'add_friend'
  get '/user/pending', to: 'friendships#pending', as: 'pending'
  get '/user/requests', to: 'friendships#requests', as: 'requests'
  post '/user/requests/:id', to: 'friendships#status', as: 'status'
  delete '/user/requests/:id', to: 'friendships#friendship_delete', as: 'friendship_delete'
  resources :posts, only: %i[index create] do
    resources :comments, only: [:create]
    resources :likes, only: %i[create destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
