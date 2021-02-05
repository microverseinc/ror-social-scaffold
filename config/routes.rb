Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
    
  resources :friendships do 
    member do 
      get 'send_request'
      get 'pending_friends'      
    end 
  end 
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]    
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
