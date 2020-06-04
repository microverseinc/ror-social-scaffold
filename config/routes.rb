Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users


  post '/request_friendship/:id', to: 'users#request_friendship'
  post '/accept_friendship/:id', to: 'users#accept_friendship'
  delete '/reject_friendship/:id', to: 'users#reject_friendship'
  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
