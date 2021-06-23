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
   
    @posts = @user.posts.ordered_by_most_recent
  end

  def my_friends
    @friendships = Friendship.where(user_id: current_user.id, confirmed: true)
    @friendships += Friendship.where(friend_id: current_user.id, confirmed: true)
  end

  def requests
    @pending_requests = Friendship.where(user_id: current_user.id, confirmed:nil)  
    @friend_requests = Friendship.where(friend_id: current_user.id, confirmed:nil)
    
  end
end
