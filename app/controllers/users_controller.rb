class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @pending_friend_requests = @user.received_requests.select {|request| request.status == 'pending'}
    @is_current_user = is_current_user
    @pending_friend = pending_friend?
    @add_friend = add_friend?
    if pending? 
      flash[:notice] = "A friendship request was sent and is awaiting confirmation"
    end
  end
end

private

def is_current_user
  current_user == @user
end

def add_friend?
  true unless is_current_user || @user.friend?(@current_user) || pending?
end

def pending?
  @current_user.pending?(@user)
end

def pending_friend? 
  current_user.request_from?(@user)
end
