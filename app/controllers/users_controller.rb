class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    store_location_for(:user, users_path)
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    store_location_for(:user, user_path(@user))
    @posts = @user.posts.ordered_by_most_recent
  end
end
