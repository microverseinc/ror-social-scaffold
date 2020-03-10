class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @all_friendships = Friendship.all
    @logged_user = current_user
  end

  def show
    @user = User.find(params[:id])
    @logged_user = current_user
    @posts = @user.posts.ordered_by_most_recent
    @all_friendships = Friendship.all
  end
end
