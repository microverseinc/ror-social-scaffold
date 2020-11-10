class FriendshipsController < ApplicationController
  def new
    # @friendship = Friendship.new
  end

  def create
    @friend = User.find_by(id: params[:friend_id])
    flash[:danger] = 'Invalid friend request' unless @friend
    if current_user.friend?(@friend)
      flash[:alert] = "You're already friends with this user"
    elsif current_user.pending_friends.include?(@friend)
      flash[:alert] = 'Friend request previously sent to this user'
    elsif current_user.send_request(@friend.id)
      flash[:success] = 'Friend request sent!'
    else
      flash[:danger] = 'Friend request not sent'
    end
    redirect_back
  end
end

private

def friendship_params
  params.require(:friendship).permit(:user_id, :friend_id)
end
