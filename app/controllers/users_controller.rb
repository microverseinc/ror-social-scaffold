class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all_except(current_user)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def accept_friend
    @user = User.find(params[:id])
    current_user.confirm_friend(@user)
    redirect_to users_path, notice: "You and #{@user.name} are friends"
  end
end
