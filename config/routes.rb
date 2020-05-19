Rails.application.routes.draw do


  root 'posts#index'

  delete 'remove_friend' => 'friendships#destroy'
  get 'send_invite' => 'friendships#send_invitation'
  get 'accept_invite' => 'friendships#accept_invitation'
  get 'pending_invite' => 'friendships#pending_invitation'
  get 'friends_list' => 'friendships#friends_list'
  delete 'reject_invite' => 'friendships#reject_invitation'

  devise_for :users
  resources :friendships
  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
