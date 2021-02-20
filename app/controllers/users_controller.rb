class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friendships = Friendship.all.select{|friendship| friendship if (friendship.received_friendship == current_user || friendship.sent_friendship == current_user) }
    @sent_friendships = @friendships.select{ |friendship| friendship if friendship.sent_friendship == current_user }
    @received_friendships = @friendships.select{ |friendship| friendship if friendship.received_friendship == current_user }
  end
end
