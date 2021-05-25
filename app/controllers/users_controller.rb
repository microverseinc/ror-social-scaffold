class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def accept
    @user = User.find(params[:user_id])

    if current_user.accept_friend(@user)
      redirect_to users_path, notice: 'Friendship confirmed'
    else
      redirect_to users_path, alert: 'Unable to accept invite, Try again later.'
    end
  end

  def decline
    @user = User.find(params[:user_id])

    if current_user.reject_friend(@user)
      redirect_to users_path, notice: 'Friendship denied.'
    else
      redirect_to users_path, alert: 'Unable to reject invite, Try again later..'
    end
  end
end
