class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.where('id != ?', current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @mutual_friends = current_user.mutual_friends(@user)
  end

  def update
    @user = User.find(params[:user_id])

    if current_user.confirm_friend(@user)
      redirect_to users_path, notice: 'Accepted Friendship Invitation.'
    else
      redirect_to users_path, alert: 'Something Went Wrong'
    end
  end

  def destroy
    @user = User.find(params[:user_id])

    if current_user.reject_request(@user)
      redirect_to users_path, notice: 'Denied Friendship Invitation.'
    else
      redirect_to users_path, alert: 'Something Went Wrong.'
    end
  end
end
