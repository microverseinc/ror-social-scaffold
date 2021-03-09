class FriendshipsController < ApplicationController
  include FriendshipHelper

  def create
    friendship = Friendship.new(requestor_id: params[:requestor_id], requested_id: params[:requested_id], status: false)
    if friendship.save
      redirect_to users_path, notice: 'You send a friend request'
    else
      redirect_to users_path, alert: 'You already send a friend request to this user'
    end
  end

  def update
    friendship = Friendship.find(params[:id])
    friendship.confirm_friend

    redirect_to users_path
  end

  def destroy
    friendship = Friendship.find(params[:id])
    if friendship
      friendship.destroy
      redirect_to users_path,
                  alert: if current_user.id == params[:requested_id]
                           'You cancel the friend request'
                         else
                           'You reject this friendship'
                         end
    else
      redirect_to users_path, alert: 'You cannot reject this user'
    end
  end
end
