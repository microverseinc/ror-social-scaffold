class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.where(user_id: current_user.id)
  end

  def friends
    @friendships = Friendship.where(user_id: current_user.id, status: true)
  end

  def create
    latest_friend_id = params[:friend_id]
    @friendship = Friendship.find_or_initialize_by(user_id: current_user.id, friend_id: latest_friend_id, status: false)
    @inverse_friendship = Friendship.find_or_initialize_by(user_id: latest_friend_id,
                                                           friend_id: current_user.id, status: false)
    if @friendship.save && @inverse_friendship.save
      redirect_to users_path, notice: 'you sent a friend invitation!'
    else
      timeline_posts
      render :index, alert: 'could not send the friend request'
    end
  end

  def update
    latest_friend_id = params[:friend_id]
    @friendship = Friendship.where(user_id: current_user.id, friend_id: latest_friend_id)
    @inverse_friendship = Friendship.where(user_id: latest_friend_id, friend_id: current_user.id)
    if @friendship.update_all(status: true) && @inverse_friendship.update_all(status: true)
      redirect_to user_path(current_user), notice: 'you accepted the invitation'
    else
      timeline_posts
      render :index, alert: 'could not process your request'
    end
  end

  def destroy
    latest_friend_id = params[:friend_id]
    @friendship = Friendship.find_by(user_id: current_user.id, friend_id: latest_friend_id)
    @inverse_friendship = Friendship.find_by(user_id: latest_friend_id, friend_id: current_user.id)
    if Friendship.destroy(@friendship.id) && Friendship.destroy(@inverse_friendship.id)
      redirect_to user_path(current_user), notice: 'destroyed that friendship'
    else
      notice[:alert] = 'something broke'
    end
  end

  private

  def friendships_params
    params.require(:friendship).permit(:friend_id, :confirmed)
  end
end
