class FriendshipsController < ApplicationController
  def index
    get_friends
    store_location
  end

  def create
    @friend = User.find_by(id: params[:friend_id])
    flash[:danger] = 'Invalid friend request' unless @friend
    if current_user.friend?(@friend)
      flash[:alert] = "You're already friends with this user"
    elsif current_user.pending_friends.include?(@friend)
      flash[:alert] = 'Friend request previously sent to this user'
    elsif current_user.send_request(@friend)
      flash[:success] = 'Friend request sent!'
    else
      flash[:danger] = 'Friend request not sent'
    end
    redirect_back
  end

  def update
    friendship = Friendship.find_by(id: params[:id])
    if friendship and current_user.accept_friend(friendship.user)
      flash[:alert] = "You are now friends with #{friendship.user.name}"
    end
    redirect_back
  end

  def destroy
    friendship = Friendship.find_by(id: params[:id])
    @friend = friendship.friend
    flash[:alert] = 'Friend deleted' if friendship&.destroy
    redirect_back
  end

  private

  def get_friends
    @friends = current_user.friends.paginate(page: params[:page])
    @pending_friends = current_user.pending_friends.paginate(page: params[:page])
    @friend_requests = current_user.friend_requests.paginate(page: params[:page])
  end
end
