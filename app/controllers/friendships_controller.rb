class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[destroy update]

  def create
    @friendship = Friendship.create(friendship_params)
    @friendship.save
    redirect_to request.referrer
  end

  def update
    @friendship.update(friendship_params)
    redirect_to request.referrer
  end

  def destroy
    @friendship.destroy
    redirect_to request.referrer
  end

  private

  def friendship_params
    params.permit(:requester_id, :receiver_id, :confirmed)
  end

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end
end
