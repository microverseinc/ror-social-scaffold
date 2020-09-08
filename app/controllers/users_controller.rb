class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def unfriend
    user = User.find(params[:user_id])
    current_user.remove_friend(user)
    redirect_to users_path, notice: "You unfriend #{user.name}."
  end
end
