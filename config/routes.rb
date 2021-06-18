Rails.application.routes.draw do

  resources :friendships
  root 'posts#index'

  devise_for :users
  
  get  'friendships/:id', to: 'friendships#destroy', as: 'destroy'

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
