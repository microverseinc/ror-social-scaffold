class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def pending_requests
    @users_requesting= current_user.users_requesting
    @users_requested= current_user.users_requested
  end
end
