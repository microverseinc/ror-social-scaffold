class FriendshipsController < ApplicationController
  def index
    @incoming = current_user.incoming_friend_requests
    @outgoing = current_user.friend_requests
  end

  def new
    @friendship = Friendship.new
  end

  # accepting friend request
  def create
    @user = User.find(current_user)
    friend = User.find(params[:id])
    @friend_request = current_user.friend_requests.new(friend_id: friend)

    return unless @friend_request.save

    redirect_to user_path(current_user)
  end

  def send_request
    @friendship = set_friendship
    if @friendship.friend_requests.include?(friend_id)
      redirect_to @friendship, alert: 'Request was already sent'
    else
      @friendship.friend_requests << friend
      friend.pending_friends << current_user
      redirect_to @friendship, notice: 'Friend request sent successfuly!'
    end
  end

  def confirm_request
    @friendship = set_friendship
    @friendship.confirm_friends << friend
    redirect_to @friendship, notice: 'Friend request sent successfuly!'
  end

  def cancel_friend_request
    friend_requester = User.find(params[:friend_id])
    friend_request = friend_requester.friendships.find(params[:id])
    friendship = current_user.friendships.find_by_friend_id(friend_requester.id)
    if friendship.nil?
      friend_request.destroy
      flash[:notice] = 'Removed friend request.'
    else
      friendship.destroy
      friend_request.destroy
      flash[:notice] = 'Removed friendship.'
    end
    redirect_to current_user
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def set_friend_request
    @friend_request = Friend.find_by_user_id_and_friend_id(params[:friend_id], params[:id])
  end

  # def friendship_params
  #   params.require(:friendship).permit(:user_id, :friend_id, :confirmed)
  # end
end
