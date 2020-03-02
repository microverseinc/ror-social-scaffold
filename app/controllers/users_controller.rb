class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def send_request
    current_user.friendships.create(friend_id: params[:id])
    flash[:success] = 'Friend request sent'
    redirect_to root_path
  end

  def accept_request
    user = User.find(params[:id])
    current_user.confirm_friend(user)
    flash[:success] = "You are now friends with #{user.name}"
    redirect_to root_path
  end
end
