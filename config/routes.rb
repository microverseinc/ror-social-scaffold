Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :friendships
  patch "Confirm", to: "friendships#confirm", as: "confirm"
  delete "Reject", to: "friendships#reject", as: "reject"
  get 'signup', to: 'users#new', as: 'signup'

  resources :users, only: [:index, :show, :create] do
    resources :friendships
  end

  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
