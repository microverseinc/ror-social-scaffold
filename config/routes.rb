Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    resources :friendships, only: [:index, :create, :update, :destroy]
  end


  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  get '/confirm/:user_id/' => 'friendships#update', as: :confirm
  get '/reject/:user_id/' => 'friendships#destroy', as: :reject
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
