class FriendshipsController < ApplicationController
  include FriendshipsHelper

  def create
    friendship = Friendship.new(requestor_id: params[:requestor_id], requested_id: params[:requested_id], status: false)
    if friendship.save
      redirect_to users_path, notice: 'You send a friend request'
    else
      redirect_to users_path, alert: 'You already send a friend request to this user'
    end
  end

  def update
    new_friendship = Friendship.new(requestor_id: current_user.id, requested_id: params[:requested_id], status: true)
    friendship = Friendship.find(params[:id])
    friendship.status = true
    if new_friendship.save && friendship.save
      redirect_to users_path, notice: 'Now you\'re friends'
    else
      redirect_to users_path, alert: 'This user is already your friend'
    end
  end

  def destroy
    friendship = Friendship.find(params[:id])
    if friendship
      friendship.destroy
      redirect_to users_path, notice: if current_user.id == params[:requested_id]
                                        'You reject this friendship'
                                      else
                                        'You cancel the friend request'
                                      end
    else
      redirect_to users_path, alert: 'You cannot reject this user'
    end
  end
end
