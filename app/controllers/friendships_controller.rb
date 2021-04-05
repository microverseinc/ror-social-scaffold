class FriendshipsController < ApplicationController
  def create
    puts "Yusif"
    puts params[:id]
    user = current_user.friendships.build(friend: User.find(params[:id].to_i));
    if user.save
      redirect_to request.referrer, alert: 'Friendship request successfully sent.'
    else
      redirect_to request.referrer, alert: 'Friendship request NOT sent.'
    end
  end
end