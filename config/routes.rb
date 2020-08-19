Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  get 'users/:id/invite' => 'friendships#invite'
  get 'users/:id/accept' => 'friendships#accept'
  get 'users/:id/reject' => 'friendships#reject'
  get 'friends' => 'friendships#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
