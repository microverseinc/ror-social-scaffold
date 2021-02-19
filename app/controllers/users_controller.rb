class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @received_friendships = @user.received_friendships
    @sent_friendships = @user.sent_friendships
  end
end
