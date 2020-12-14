class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def new; end

  def create
    friend_id = params[:friend_id]
    @friendship = Friendship.find_or_create_by(user_id: current_user.id, friend_id: friend_id, requestor_id: current_user.id)
    @friendship = Friendship.find_or_create_by(user_id: friend_id, friend_id: current_user.id, requestor_id: current_user.id)
  end

  def update
    user = User.find(params[:user_id])
    friend =  User.find(current_user.id)
    @friendship = Friendship.find_by_user_id_and_friend_id(user, friend)
    @friendship.confirmed = true
    @friendship.save
    @friendship = Friendship.find_by_user_id_and_friend_id(friend, user)
    @friendship.confirmed = true
    @friendship.save
    redirect_to users_path
  end

  def destroy
    user = User.find(params[:user_id])
    friend =  User.find(params[:friend_id])
    Friendship.find_by_user_id_and_friend_id(user, friend).destroy
    Friendship.find_by_user_id_and_friend_id(friend, user).destroy
    redirect_to users_path
  end
end
