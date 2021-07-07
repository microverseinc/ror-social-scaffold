class FriendshipsController < ApplicationController
  def create
    Friendship.safe_create(params[:inviter_id],params[:invitee_id])
    if params[:mode] == 'profile'
      redirect_to user_path(User.find(params[:invitee_id]))
    else
      redirect_to users_path
    end
  end

  def update
    Friendship.find_by(user_id: params[:invitee_id], friend_id: params[:inviter_id]).update(status: true)
    redirect_to user_path(User.find(params[:inviter_id]))
  end

  def destroy
    Friendship.find_by(user_id: params[:inviter_id],
    friend_id: params[:invitee_id]).delete
    Friendship.find_by(user_id: params[:invitee_id],
       friend_id: params[:inviter_id]).delete
    redirect_to user_path(User.find(params[:show_user]))
  end
end
