class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def friend_request
    @user = User.find(params[:id])
    Friendship.create(user_id: current_user.id, friend_id: user_id, status: false)
    redirect_to root_path, notice: 'Friend request was sent successfully'
  end

  def confirm_friend
    @user = User.find(params[:id])
    current_user.confirm_friend(user)
    redirect_to user, notice: 'Accepted friend request!'
  end

  def pending_friends
    @pending_friends = current_user.pending_friends
  end

  def reject_request
    @user = User.find(params[:id])
    current_user.reject_request(user)
    redirect_to root_path, notice: 'friend request has been rejected!'
  end

end
