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
      redirect_to users_path, notice: 'Friendship invitation accepted .'
    else
      redirect_to users_path, alert: 'woohps something went wrong with accepting the  invite.'
    end
  end

  def decline
    @user = User.find(params[:user_id])

    if current_user.reject_friend(@user)
      redirect_to users_path, notice: 'Friendship request denied successfully.'
    else
      redirect_to users_path, alert: 'woohps something went wrong with the rejection.'
    end
  end

end
