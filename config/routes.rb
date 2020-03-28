Rails.application.routes.draw do

  root 'posts#index'

  post 'user/sendrequest/:id', to: 'users#send_request', as: 'sendrequest'
  post 'user/recieverequest/:id', to: 'users#accept_request', as: 'recieverequest'
  delete 'friendships/unfriend/:id', to: 'friendships#unfriend', as: 'unfriend'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  resources :friendships, except: [:edit, :show, :delete]
  # post 'accept_friend', action: :update, controller: 'friendships'
  # delete 'delete_request', action: :destroy, controller: 'friendships'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
