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
    current_user.confirm_friend(@user)
    redirect_to request.referrer, notice: "Confirmed friend request"
  end

  def decline
    user = user.find(params[:data])
    friendship = @user.inverse_friendshiips.find { |f| f.user == user } 
    friendship.destroy
    redirect_to request.referrer, notice: "Declined friend request"
  end

end
