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
    @friendship = Friendship.find_by user_id:current_user.id,friend_id: params[:id] 
    @frienship_reverse = Friendship.find_by friend_id:current_user.id,user_id: params[:id] 
    if @friendship
    @friendship.destroy
    else 
      @frienship_reverse.destroy
    end
    redirect_to users_path
  end
end
