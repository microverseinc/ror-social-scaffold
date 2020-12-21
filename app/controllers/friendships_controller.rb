class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[destroy update]
  before_action :set_friendship_both, only: %i[destroy_both accept_both]

  def index
    @friends = current_user.friendships.all
  end

  def create
    @friendship = Friendship.create(friendship_params)
    @friendship.save
    redirect_to request.referrer
  end

  def destroy
    @friendship.destroy
    redirect_to request.referrer
  end

  def update
    @friendship.update(friendship_params)
    redirect_to request.referrer
  end

  def accept_both
    # byebug
    @friendships_pair.update_all(status: 'confirmed')
    redirect_to request.referrer
  end

  def destroy_both
    @friendships_pair.destroy_all
    redirect_to request.referrer
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id, :status)
  end

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def set_friendship_both
    @friendship = Friendship.find(params[:id])
    @user_id = @friendship.user_id
    @friend_id = @friendship.friend_id
    @friendships_pair = Friendship.where(
      "(user_id = #{@user_id} AND friend_id = #{@friend_id})
      OR (user_id = #{@friend_id} AND friend_id = #{@user_id})"
    )
  end
end
