class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])

    @friendship = current_user.friendships.new
    @friendship.friend_id = @user.id
    @friendship.requester_id = current_user.id

    @friendship.save

    redirect_to request.referrer, notice: 'Friend request sent'
  end

  def update
    @user = User.find(params[:user_id])
    # @friendship = Friendship.find_friendship(current_user, @user).first

    current_user.confirm_friend(@user)

    redirect_to request.referrer, notice: 'Friend request approved'
  end

  def destroy
    @user = User.find(params[:user_id])
    @friendships = Friendship.find_both_friendships(current_user, @user)

    @friendships.each(&:destroy)

    redirect_to request.referrer, notice: "Friendship with `#{@user.name}` cancelled"
  end
end
