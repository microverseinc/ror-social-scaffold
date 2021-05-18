class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @pending_friends = current_user.pending_requests
    @requesting_friends = current_user.friend_requests
  end

  def send_request
      current_user.send_request(User.find(params[:user_id]))
      redirect_to user_path(current_user), flash: { success: 'request sent' }
  end

  def confirm_request
      current_user.confirm_request(User.find(params[:user_id]))
      redirect_to user_path(current_user), flash: { success: 'you have confirmed the friend request' }
  end

  def reject_request
     current_user.reject_request(User.find(params[:user_id]))
     redirect_to user_path(current_user), flash: { success: 'you have rejected the friend request' }
  end

end
