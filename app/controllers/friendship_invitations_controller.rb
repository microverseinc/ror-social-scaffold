class FriendshipInvitationsController < ApplicationController
  def create
    invitation = FriendshipInvitation.new(invitation_params)
    if invitation.save
      redirect_to users_path, notice: 'Invitation sent'
    else
      flash.now.alert = 'Error'
      render users_path
    end
  end

  def destroy
    if @invitation.destroy
      redirect_to users_path, notice: 'Friendship canceled'
    else
      flash.now.alert = 'Error'
      render users_path
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:inviter_id, :invitee_id)
  end
end
