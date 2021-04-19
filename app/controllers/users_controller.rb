class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def add_friend
    friend = User.find(params[:id])
    Friendship.create(user: current_user, friend: friend)
    redirect_to users_path
  end
end
