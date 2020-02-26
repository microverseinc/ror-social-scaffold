Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

   post 'user/sendrequest/:id', to: 'users#send_request', as: 'sendrequest'
  post 'user/recieverequest/:id', to: 'users#accept_request', as: 'recieverequest'

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
