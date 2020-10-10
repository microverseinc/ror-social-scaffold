Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  get '/send_request', to: 'friendships#create'
  delete '/decline_request', to: 'friendships#destroy'
  get '/accept_request', to: 'friendships#accept'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
