class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def new
    @friendship_created = current_user.friendships.build
  end

  def create
    @friendship_created = current_user.friendships.build
    @friendship_created.friend_id = params[:user_id]

    if @friendship_created.save
      redirect_to users_path, notice: 'Friend Added'
    else
      redirect_to users_path, notice: @friendship_created.errors.full_messages
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.confirmed = true
    @inverse_friendship = Friendship.create(friend_id: @friendship.user_id,
                                            user_id: @friendship.friend_id,
                                            confirmed: true)
    if @inverse_friendship.save && @friendship.save
      redirect_to users_path, notice: 'Friend request was accepted.'
    else
      redirect_to users_path, alert: "Couldn't accept friend request."
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship.destroy
      redirect_to request.referrer, notice: 'Friendship was rejected.'
    else
      redirect_to request.referrer, alert: 'Error rejecting friendship.'
    end
  end

  private

  def friendship_params
    params.require(:friendships).permit(:friend_id, :user_id)
  end
end
