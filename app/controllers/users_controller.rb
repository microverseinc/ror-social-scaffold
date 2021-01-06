class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @other_users = User.where.not(id: current_user.id) if current_user
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
