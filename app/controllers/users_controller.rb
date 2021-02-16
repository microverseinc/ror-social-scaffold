class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @current_user_id = current_user.id
    @friend_request = current_user.friendships
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
