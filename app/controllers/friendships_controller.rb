class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.all
  end

  def create
    @friendid = params[:user_id]
    return if @friendid == current_user.id
    if Friendship.where(user_id: current_user.id,
                        friend_id: @friendid).exists? || Friendship.where(user_id: @friendid,
                                                                          friend_id: current_user.id).exists?
      return
    end

    @friendship = current_user.friendships.build(friend_id: @friendid)
    redirect_to users_path if @friendship.save
  end

  def confirm
    @friend = User.find(params[:id])
    current_user.confirm_friend(@friend)
    redirect_to users_path
  end

  def destroy
    @friendship = Friendship.where(params[:id] == :user_id || params[:id] == :friend_id).first
    @friendship.destroy
    redirect_to users_path
  end
end
