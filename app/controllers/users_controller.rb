class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = current_user.id
    @posts = @user.posts.ordered_by_most_recent
  end
end
