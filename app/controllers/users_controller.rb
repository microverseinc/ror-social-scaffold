class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where( 'id != ?', current_user.id).all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
