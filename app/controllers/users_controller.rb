class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friend_requests = @user.friend_requests.all
    @pending_friends = @user.pending_friends.all
    @friends = @user.friends.all 
  end
  
end
