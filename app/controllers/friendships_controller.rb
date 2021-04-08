class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(friendships_params)

    if @friendship.save
      redirect_to users_path, notice: 'you sent a friend invitation!'
    else
      timeline_posts
      render :index, alert: 'could not send the friend request'
    end
  end

  def update
    @friendship = Friendship.find(params[:id])

    if @friendship.update(confirmed: true)
      redirect_to user_path(current_user), notice: 'you accepted the invitation'
    else
      timeline_posts
      render :index, alert: 'could not process your request'
    end
  end

  def destroy 
    @friendship = Friendship.find(params[:id])

    @friendship.destroy
    redirect_to user_path(current_user), notice: 'destroyed that friendship'
  end

  private

  def friendships_params
    params.require(:friendship).permit(:friend_id, :confirmed)
  end
end
