Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    get 'pending_friends'
    get 'friend_requests'
  end
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  resources :friendships, only: [:create, :destroy, :index, :confirm, :reject] do
    post 'confirm'
    delete 'reject'
  end

  # post '/confirm/:id', to: 'friendships#confirm'
  # post '/reject/:id', to: 'friendships#reject'
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
