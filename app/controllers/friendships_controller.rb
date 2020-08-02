class FriendshipsController < ApplicationController
  def create
    id1 = params[:ids][:id1]
    id2 = params[:ids][:id2]
    @friendship = Friendship.new(user_id: id1, friend_id: id2)
    @friendship.save
    flash[:notice] = 'Friendship Created'
    redirect_to user_path(current_user.id)
  end

  def destroy
    friendship = Friendship.find(params[:friendship_id])
    user = friendship.user_id
    friend = friendship.friend_id
    if (friendship2 = Friendship.find_by(user_id: friend, friend_id: user))
      friendship2.destroy
    end
    friendship.destroy
    flash[:notice] = 'Friendship Canceled'
    redirect_to user_path(current_user.id)
  end

  def update
    friendship = Friendship.find(params[:friendship_id])
    if friendship.update(confirmed: true)
      friendship = Friendship.new(user_id: friendship.friend_id, friend_id: friendship.user_id, confirmed: true)
      friendship.save
    end
    flash[:notice] = 'Friendship Accepted'
    redirect_to user_path(friendship.friend_id)
  end
end
