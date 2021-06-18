Rails.application.routes.draw do
  resources :friendships
  root 'posts#index'

  devise_for :users

  get 'friendships/:id', to: 'friendships#destroy', as: 'destroy'

  resources :users, only: %i[index show]
  resources :posts, only: %i[index create] do
    resources :comments, only: [:create]
    resources :likes, only: %i[create destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
