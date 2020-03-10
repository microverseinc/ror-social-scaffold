Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  post '/send_request', to: 'friendships#send_request'
  post '/requests', to: 'friendships#accept'
  delete '/requests', to: 'friendships#decline'
  get '/requests', to: 'friendships#show_requests'

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
