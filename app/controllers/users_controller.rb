class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @received = Friendship.where(friend_id: @user.id, confirmed: false)
    @send = Friendship.where(user_id: @user.id, confirmed: false)
  end
end
