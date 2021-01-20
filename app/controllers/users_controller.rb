class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @fiend= Friendship.where(friend_id: [current_user, params[:id]], user_id: [current_user, params[:id]]).first
  end
end
