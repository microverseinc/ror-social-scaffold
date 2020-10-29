class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends_hash = {}
    pull_friends
    store_location
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

  def update
    friendship = current_user.inverse_friendships.find_by(id: params[:id])
    if friendship and current_user.accept_friend(friendship.user_id)
      flash[:alert] = "You are now friends with #{friendship.user.name}"
    end
    redirect_back
  end

  def destroy
    friendship = Friendship.find_by(id: params[:id])
    flash[:alert] = 'Friend deleted' if friendship&.destroy
    redirect_back
  end

  private

  def pull_friends
    case params[:friendship_type]
    when 'friend'
      @friends_hash[:friends_type] = 'friend'
      @friends_hash[:title] = 'Friends'
      @friends_hash[:friends] = current_user.friends.paginate(page: params[:page])
    when 'pending_friend'
      @friends_hash[:friends_type] = 'pending_friend'
      @friends_hash[:title] = 'Pending Friends'
      @friends_hash[:friends] = current_user.pending_friends.paginate(page: params[:page])
    when 'friend_request'
      @friends_hash[:friends_type] = 'friend_request'
      @friends_hash[:title] = 'Friend Requests'
      @friends_hash[:friends] = current_user.friend_requests.paginate(page: params[:page])
    end
  end
end
