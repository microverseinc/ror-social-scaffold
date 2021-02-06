class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friend_requests = @user.friend_requests
    @pending_friends = @user.pending_friends
    @friends = @user.friends
  end  

  def create_friendship
    @user = User.find(params[:id])
    friendship = current_user.create_friendship(@user.id)
    friendship.save
    redirect_to root_path, notice: 'You successfully registered for this event!'
  end 
end
