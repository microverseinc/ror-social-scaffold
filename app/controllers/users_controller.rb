class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def my_friends
    @friendships = Friendship.where(user_id: current_user.id, confirmed: true)
    @friendships += Friendship.where(friend_id: current_user.id, confirmed: true)
    @friendships.compact
  end

  def requests
    @pending_requests = Friendship.where(user_id: current_user.id, confirmed: nil)
    @friend_requests = Friendship.where(friend_id: current_user.id, confirmed: nil)
  end
end
