Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users
  
  resources :users, only: [:index, :show] do
  end
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  post 'invite', to: 'friendrequests#create'
  put 'invite', to: 'users#update'
  delete 'reject', to: 'users#destroy'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
