Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  get '/member-data', to: 'members#show'

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create, :index]
    resources :likes, only: [:create, :destroy]
  end
  resources :friendships

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
