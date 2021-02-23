class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @mutual_friends = current_user.mutual_friends(@user)
    @pending_friends = @user.pending_friends
  end
end
