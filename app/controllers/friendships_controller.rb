class FriendshipsController < ApplicationController
  include ApplicationHelper

  def index
    @friendship = current_user.Friendship.all
  end

  def create
    @user = User.find(params[:requester_id])
    @friendships = current_user.friendships.new
    @friendships.friend_id = @user.id
    @friendships.requester_id = current_user.id
    @friendships.save

    redirect_to users_path, notice: 'Friend Request sent!'
  end

  def update
    @friendship = Friendship.find_by(requester_id: params[:requester_id])
    @friendship.confirmed = true
    @friendship.save

    redirect_to users_path, notice: 'Friend request was successfully confirmed.'
  end

  def destroy
    @user = User.find(params[:user_id])
    @friendships = Friendship.inverse_friendships(current_user, @user)
    @friendships.each(&:destroy)

    redirect_to request.referrer, notice: "Friendship with `#{@user.name}` cancelled"
  end
end
