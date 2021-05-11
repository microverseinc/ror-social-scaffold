class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id], confirmed: false)
    if @friendship.save
      redirect_to users_path, notice: "You invited #{@friendship.friend.name}!"
    else
      redirect_to users_path, alert: 'You cannot invite this friend.'
    end
  end

  def update
    friend = User.find(params[:user_id])
    current_user.confirm_friend(friend)
    redirect_to users_path(current_user), notice: "#{friend.name} is now your friend"
  end

  def destroy
    friend = User.find(params[:user_id])
    current_user.reject_friend(friend)
    redirect_to user_path(current_user), notice: "You've rejected #{friend.name} :("
  end
end
