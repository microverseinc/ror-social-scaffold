Rails.application.routes.draw do

  root 'posts#index'
  post 'friendships/create'

  devise_for :users

  resources :users, only: [:index, :show] do
    member do 
      post :confirm
      delete :destroy
    end
  end
  
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # Api routing
  namespace :api do
    namespace :v1 do
    
      post :auth, to: 'auth#create'

      defaults format: :json do
        resources :posts, only: [:index, :show] do
          resources :comments, only: [:create]
        end
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
