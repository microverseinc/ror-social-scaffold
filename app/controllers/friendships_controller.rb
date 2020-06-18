class FriendshipsController < ApplicationController
  def index
    @friend_list = Friendship.all
  end

  def create
    @friend = Friendship.create(friendship_params)
    # dinamic redirect since is caled in different pages
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @relationship = Friendship.find(params[:id])
    if (@reverse_relationship = Friendship.find_by(user_id: @relationship.friend_id, friend_id: @relationship.user_id))
      @reverse_relationship.destroy
    end
    @relationship.destroy
    redirect_to friendships_path
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update(acceptance: true)
    redirect_to friendships_path
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id)
  end
end
