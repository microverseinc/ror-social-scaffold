class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id])
    if @friendship.save
      flash[:notice] = "Friend request has been sent to #{user.name.capitalize}"
      redirect_to users_path
    else
      render 'new'
    end
  end

  # Accept Friendship
  def update
    @friendship = if user.id == current_user.id
                    Friendship.find_by_id(params[:id]) # for current_user, show page
                  else
                    Friendship.find_by_user_id(params[:id]) # _user page, user
                  end
    @friendship.status = true
    flash[:notice] = "You accepted friend request from #{@friendship.user.name.capitalize}" if @friendship.save
    redirect_to user_path(user)
  end

  def destroy
    @friend = Friendship.find_by_id(params[:id])
    flash[:notice] = "You denied friend request from #{@friend.user.name.capitalize}" if @friend.destroy
    redirect_to user_path(user)
  end

  private

  def user
    @friend = User.find(params[:user_id])
  end
end
