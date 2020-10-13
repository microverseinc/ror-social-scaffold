# rubocop: disable Style/GuardClause

class FriendshipsController < ApplicationController
  def add_friend
    @user = User.find(params[:id])
    unless Friendship.where(user_id: current_user.id, friend_id: @user.id, confirmed: (false || true)).exists?
      @frienship = current_user.friendships.create(friend_id: params[:id])
      redirect_to user_path
    end
  end

  def accept_request
    @friendship = Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
    @friendship.confirmed = true
    @friendship.save
    # This is the line we added to accomplish the friendship v2
    current_user.friendships.create(friend_id: params[:id], confirmed: true)
  end

  def decline
    @friendship = Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
    @friendship.destroy
    redirect_to user_path
  end
end

# rubocop: enable Style/GuardClause
