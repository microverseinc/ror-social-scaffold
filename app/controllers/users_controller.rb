class UsersController < ApplicationController
  before_action :authenticate_user!
  # scope :pending_requests, -> { where(friend_id: current_user.id) }
  # where("friend_id = ?",current_user.id)

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @friendships = @user.friendships.all
    # debugger
    @posts = @user.posts.ordered_by_most_recent
  end

# code from lastnight
  def my_friends
    @friendships = current_user.friendships
  end

  def pending_requests
    
  end
end
