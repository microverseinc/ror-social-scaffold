Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] 
  resources :friendshipps 
  #   collection do
  #     get 'accept_friend'
  #     get 'decline_friend'
  #   end
  # end

  put 'accept_friend', to: 'friendshipps#accept'
  delete 'decline_request', to: 'friendshipps#reject'

  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
