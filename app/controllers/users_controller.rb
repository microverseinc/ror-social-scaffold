class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all_except_current_user(current_user)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @pending_request = current_user.friend_requests
  end

  def add_friend
    @user = User.find(params[:id])
    current_user.confirm_friend(@user)
    redirect_to users_path, notice: 'You are now friends'
  end
end
