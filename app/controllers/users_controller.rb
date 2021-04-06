class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @use = User.all
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friendships = Friendship.all
   
  end
end
