Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root 'posts#index'
  post 'invite', to: 'friendships#create'
  put 'invite', to: 'users#update'
  delete 'reject', to: 'users#destroy'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :friendships

  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  namespace :api do
    devise_for :users, defaults: {format: :json},
    class_name: 'ApiUser',
    skip: [:registerations, :invitations, :passwords, :confirmations, :unlocks],
    path: '',
    path_names: { sign_in: 'login', sign_out: 'logout' }

    devise_scope :user do
      get 'login', to: 'devise/sessions#new'
      delete 'logout', to: 'devise/sessions#destroy'
    end
  end
end
