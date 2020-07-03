class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @pending_friends = @user.pending_friends
    @friend_requests = @user.friend_requests
    @friends = @user.friends
  end

  def create_friend
    @friend = User.find(params[:friend_id])
    @invite = current_user.confirm_friend(@friend)
    redirect_to root_path, notice: 'Friend Accepted'
  end

  def create_friend_request
    @friend = User.find(params[:friend_id])
    @sent_request = current_user.send_friend_request(current_user, @friend)
    redirect_to root_path, notice: 'Friend Request Sent successfully'
  end

  def reject_friend_request
    @friend = User.find(params[:friend_id])
    @reject_request = current_user.reject_friend_request(@friend)
    redirect_to root_path, notice: 'Friend Request Rejected successfully'
  end

  def unfriend
    @friend = User.find(params[:friend_id])
    @unfriend = current_user.unfriend(@friend)
    redirect_to root_path, notice: 'Unfriend successfully'
  end
  

end
