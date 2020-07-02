class UsersController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :my_self?, only: :add_friend
  before_action :already_sent?, only: :add_friend

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def add_friend
    @friend = find_user
    new_friend = current_user.friendships.build(friend_id: @friend.id)
    if new_friend.save
      flash[:succes] = 'Friend request sended'
      redirect_to user_path(@friend)
    else
      flash[:danger] = 'Something went wrong'
    end
  end

  private

  def my_self?
    user = find_user
    return unless current_user == user

    flash[:warnign] = 'You cannot befriend yourself'
    redirect_to users_path
  end

  def already_sent?
    return unless (fstatus = current_user.status?(find_user))

    flash[:warnign] = fstatus
    redirect_to User_path(current_user)
  end

  def find_user
    User.find_by(id: params[:id])
  end
end
