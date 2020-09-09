class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @pending_friend_requests = Friendship.where(status: 'pending', inverse_friend: current_user)
    @logged_in_user = current_user?
    @pending_friend = pending_friend?
    @add_friend = add_friend?
    flash[:notice] = 'A friendship request was sent and is awaiting confirmation' if pending?
  end
end

private

def current_user?(user = @user)
  current_user == user
end

def add_friend?(user = @user)
  true unless current_user?(user) || user.friend?(current_user) || pending?(user)
end

def pending?(user = @user)
  current_user.pending?(user)
end

def pending_friend?(user = @user)
  current_user.request_from?(user)
end
