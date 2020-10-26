class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_login, only: [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
