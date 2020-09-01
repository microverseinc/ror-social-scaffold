class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @pending_friend_requests = @user.received_requests.map{|request| request.status = 'pending'}
    @is_current_user = is_current_user
    @add_friend = add_friend?
  end
end

private

def is_current_user
  current_user == @user
end

def add_friend?
  true unless is_current_user || @user.friend?(@current_user)  
end

