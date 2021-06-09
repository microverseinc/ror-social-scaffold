class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id])

    if @friendship.save
      redirect_to users_path, notice: 'You succesfully made friend request.'
    else
      redirect_to users_path, alert: 'You cannot send friend request.'
    end
  end


  def update
    if @user.pending_friends.include?(@friend)
      Friendship.confirm_friend(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.name} accepted!"
    else
      flash[:notice] = "No friendship request from #{@friend.name}."
    end
    redirect_to root_path
  end
  
  def setup_friend
    @user = current_user
    @friend = User.find(params[:id])
  end

  def destroy
    friendship = Friendship.find_by(id: params[:id], user: current_user, user_id: params[:user_id])
    if friendship
      friendship.destroy
      redirect_to users_path, notice: 'You are no longer friends with this user.'
    else
      redirect_to users_path, alert: 'You can delete the is friendship.'
    end
  end

  
end
