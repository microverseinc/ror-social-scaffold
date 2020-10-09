Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  resources :friendships, only: [:create, :destroy, :approve] do
    #post '/addfriend',  to:'friendships#create'
    #get '/addfriend',  to:'friendships#create'
    get '/unfriend', to:'friendships#destroy'
    post '/unfriend', to:'friendships#destroy'

    get '/approve_friendship', to:'friendships#approve'
    post '/approve_friendship', to:'friendships#approve'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
