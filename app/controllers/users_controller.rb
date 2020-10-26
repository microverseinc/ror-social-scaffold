class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.paginate(page: params[:page])
    store_location
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    store_location
  end
end
