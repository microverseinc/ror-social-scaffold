class FriendshipsController < ApplicationController
  def new
    @users = User.all
  end

  def create
    @friendship = current_user.friendships.build(friendship_params)
    if @friendship.save
      flash[:notice] = 'You have successfuly added a friend'
      redirect_to root_path
    else
      render 'new'
    end
  end


private

  def friendship_params
    params.permit(:friend_id, :confirmed)
  end
end
