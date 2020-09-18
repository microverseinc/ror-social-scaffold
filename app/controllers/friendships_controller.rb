class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friendships = current_user.inverse_friendships
  end

  def create
    @friendship = current_user.friendships.new(friend_id: params[:friend_id])
    @friendship.confirmed = false
    if @friendship.save
      redirect_to users_path, notice: 'You send a friend request.'
    else
      redirect_to users_path, alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end

  def confirm
    user = User.find(params[:user_id])
    current_user.confirm_friend(user)
    redirect_to friendships_path, notice: 'You confirmed a friend request.'
  end

  def reject
    user = User.find(params[:user_id])
    current_user.destroy_friend(user)
    redirect_to friendships_path, notice: 'You reject a friend request.'
  end
  
  private

  def friendships_params
    params.require(:friendship).permit(:friend_id, :user_id, :confirmed)
  end
end
