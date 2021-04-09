class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @friendship = Friendship.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friendship = Friendship.new
  end
end
