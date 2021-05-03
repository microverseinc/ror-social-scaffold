class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friends = @user.friends
    @my_friends = current_user.friends.uniq
    @pending_requests = current_user.pending_friends.uniq
    @requested_friends = current_user.requested_friends.uniq
  end
end
