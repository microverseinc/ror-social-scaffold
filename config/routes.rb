Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    get :friends,:pending_requests, on: :member
  end
  
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  resources :friendships, only:[:create,:destroy, :update,:delete] do
    delete :reject,:delete, on: :member
  end
end
