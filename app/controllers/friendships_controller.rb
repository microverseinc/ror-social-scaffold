class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friend = User.find(params[:friendship][:friend_id])
    if !current_user.friends.include?(@friend)
      current_user.friendships.build(friendship_params).save
      flash[:notice] = 'Friend request sent'
    else
      flash[:notice] = "You're already friends with #{@friend.name}"
    end

    redirect_back(fallback_location: user_path(@friend))
  end

  def update; end

  def destroy
    friendship = Friendship.find(params[:id])

    friendship.destroy
    flash[:notice] = 'Friendship deleted'
    redirect_back(fallback_location: users_path)
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end

  def existing_friendship?
    # current_user.friendships.include?()
  end
end
