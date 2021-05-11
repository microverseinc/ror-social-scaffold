class FriendshipsController < ApplicationController
  def index
    @invitations = current_user.friendship_requests
  end

  def create
    invitation = Friendship.new(invitation_params)
    if invitation.save
      redirect_to users_path, notice: 'Invitation sent'
    else
      flash.now.alert = 'Error'
      render users_path
    end
  end

  def update
    inviter = User.find(invitation_params[:user_id])
    if current_user.confirm_friend inviter
      redirect_to invitations_path, notice: "#{inviter.name} is your friend now!"
    else
      flash.now.alert = 'Error'
      render users_path
    end
  end

  def destroy
    user = User.find(params[:id])
    invitation = current_user.friend_invitation user
    if invitation.destroy
      redirect_to users_path, notice: 'Friendship canceled'
    else
      flash.now.alert = 'Error'
      render users_path
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:user_id, :friend_id)
  end
end
