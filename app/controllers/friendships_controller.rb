class FriendshipsController < ApplicationController
  def all_friends
    @all_friends = current_user.friends
  end

  def send_invitation
    redirect_to users_path, notice: 'Friend request sent' if current_user.send_request(params[:user_id])
  end

  def confirm_request
    redirect_to users_path, notice: 'Friend request accepted' if current_user.confirm_friend(params[:user_id])
  end

  def reject_request
    redirect_to users_path, notice: 'Friend request denied' if current_user.reject_friend(params[:user_id])
  end

  def unfriend
    User.find(params[:user_id])
    friend = Friendship.find_by(user_id: params[:user_id], friend_id: current_user.id)
    inverse_friend = Friendship.find_by(user_id: current_user.id, friend_id: params[:user_id])
    friend&.delete
    inverse_friend&.delete
    redirect_to users_path
  end
end
