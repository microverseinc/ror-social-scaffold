Rails.application.routes.draw do

  

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]

  resources :users do
    member do
      get :create_friendship
      get :accept
      get :decline
    end
  end
  
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  get "/get_posts", to: "posts#posts_index"
  get "/comments/:post_id", to: "comments#comments_index"
  post "/add_comments/:user_id/:post_id/:content", to: "comments#create_comment"
  # post "/posts/:post_id/comments"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
