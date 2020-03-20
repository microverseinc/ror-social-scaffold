Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users
  
  post '/users/:id', to: 'friendships#create'
  delete 'friendship/:id', to: 'friendships#delete', as: 'delete_friendship'
  resources :friendships, only: %i[show edit], path: :friends
  # instead of: /friendships

  resources :users, only: [:index, :show] do # to have a nicer url like: /user/id/friends
    resources :friendships, only: %i[index], path: :friends
  end
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
