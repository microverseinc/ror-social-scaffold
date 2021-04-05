class FriendshipsController < ApplicationController
  def index 
    @friendships = current_user.friend_requests
  end

  def create
    user = current_user.friendships.build(friend: User.find(params[:id].to_i));
    if user.save
      redirect_to request.referrer, alert: 'Friendship request successfully sent.'
    else
      redirect_to request.referrer, alert: 'Friendship request NOT sent.'
    end
  end

  def update
    friendship = Friendship.find(params[:id].to_i)
    if friendship.update(confirmed: true)
      redirect_to request.referrer, alert: 'Friendship request successfully accepted.'
    else
      redirect_to request.referrer, alert: 'Friendship request NOT accepted.'
    end
  end

  def destroy 
  end
end