class FriendshipsController < ApplicationController
  def new

  end

  def create
    @new_friendship = Friendship.where( 'friend_id = ? AND user_id=?', params[:friend_id], current_user.id).or(Friendship.where('friend_id = ? AND user_id = ?', current_user.id, params[:friend_id]))

    if @new_friendship.count.zero?
      @friendship = current_user.friendships.build(friend_id: params[:friend_id])
      if @friendship.save
        redirect_to users_path,
        notice: 'Sent Friend Request'
      else
        redirect_to users_path,
        alert: 'Friend Request Not Sent'
      end

    else
       redirect_to users_path,
      alert: 'Friendship is Pending'
    end
    
  end
end

