class FriendshipsController < ApplicationController
  def send_invitation
    if current_user.send_invitation(params[:user_id])
      flash.notice = 'Friend invitation sent'
      redirect_to users_path
    else
      flash.now[:notice] = 'error occured'
    end
  end

  def accept_invitation
    if current_user.confirm_invites(params[:user_id])
      flash.notice = 'friend accepted'
      redirect_to users_path
    else
      flash.now[:notice] = 'error occured'
    end
  end

  def reject_invitation
    current_user.reject_invites(params[:user_id])
    redirect_to users_path
  end

  def pending_invitation
    @pending_invitations = current_user.pending_invites
  end

  def destroy
    user = User.find(params[:user_id])
    friend = current_user.friendships.find_by_friend_id(user)
    if friend.destroy
      flash.notice = "#{user.name} has been removed as your friend"
      redirect_to users_path
    else
      flash.now[:notice] = 'error occurred'
    end
  end

  def friends_list
    @friends_list = current_user.friends
  end
end
