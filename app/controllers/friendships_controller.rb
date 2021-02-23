class FriendshipsController < ApplicationController
  def new; end

  def create
    @friendship = Friendship.where('user_id = ? AND friend_id = ?', current_user.id, params[:friend_id]).or
    Friendship.where('user_id = ? AND friend_id = ?', params[:friend_id], current_user.id)
    if @friendship.count.zero?
      @new_friendship = current_user.friendships.build(friend_id: params[:friend_id])
      if @new_friendship.save
        redirect_to root_path,
                    notice: 'Friend request sent'
      else
        redirect_to root_path,
                    alert: 'Friend request Not sent'
      end

    elsif @friendship.count == 1
      redirect_to root_path,
                  notice: 'Friend Request is pending'

    end
  end

  def show; end

  def destroy
    @friendship = Friendship.find(params[:friendship_id])
    @friendship.destroy
    redirect_to users_path
  end

  def update
    @friendship = Friendship.find(params[:friendship_id])
    if @friendship.update({ 'status': true })
      redirect_to current_user,
                  notice: 'Friend Request Accepted '
    else
      redirect_to root_path,
                  alert: 'Friend Request Not Accepted'
    end
  end
end
