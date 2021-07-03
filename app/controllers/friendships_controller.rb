class FriendshipsController < ApplicationController
  def create
    Friendship.create(inviter_id: params[:inviter_id], invitee_id: params[:invitee_id], accepted: false)
    redirect_to user_path(User.find(params[:invitee_id]))
  end

  def update
    Friendship.find_by(inviter_id: params[:inviter_id], invitee_id: params[:invitee_id]).update(accepted: true)
    redirect_to user_path(User.find(params[:inviter_id]))
  end

  def destroy
    friendship = Friendship.find_by(inviter_id: params[:inviter_id],
                                    invitee_id: params[:invitee_id]) || Friendship.find_by(
                                      inviter_id: params[:invitee_id], invitee_id: params[:inviter_id]
                                    )
    friendship.delete
    redirect_to user_path(User.find(params[:show_user]))
  end
end
