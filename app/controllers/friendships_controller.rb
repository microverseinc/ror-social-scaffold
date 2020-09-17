class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])

    @friendship = current_user.friendships.new
    @friendship.friend_id = @user.id

    @friendship.save

    redirect_to request.referrer, notice: 'Friend request sent'
  end

  def update
    @user = User.find(params[:user_id])
    @friendship = Friendship.find_friendship(current_user, @user).first

    @friendship.confirmed = true
    @friendship.save

    redirect_to request.referrer, notice: 'Friend request approved'
  end

  def destroy
    @user = User.find(params[:user_id])
    @friendship = Friendship.find_friendship(current_user, @user).first

    @friendship.destroy

    redirect_to request.referrer, notice: "Friendship with `#{@user.name}` cancelled"
  end
end
