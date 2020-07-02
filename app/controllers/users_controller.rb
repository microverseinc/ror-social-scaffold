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

end
