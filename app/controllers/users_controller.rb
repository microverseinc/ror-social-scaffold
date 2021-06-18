class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @received = current_user.friendships.where(:friend_id => current_user.id, :confirmed => false)
  end
end
