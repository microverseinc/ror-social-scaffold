class FriendshipsController < ApplicationController
  include ApplicationHelper
  include FriendshipsHelper
  before_action :authenticate_user!
  def new; end

  def create
    friend_id = params[:friend_id]
    @friendship = Friendship.find_or_create_by(user_id: current_user.id, friend_id: friend_id)
  end

  def update
    user = User.find(params[:user_id])
    confirm_a_request(user)
  end

  def destroy
    friendship = Friendship.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
    friendship.destroy
  end
end
