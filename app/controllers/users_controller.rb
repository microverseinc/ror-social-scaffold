class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @friendship_invites
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  private

  def friendship_invites
    @friendship_invites ||= Friendship.all.ordered_by_most_recent.includes(:user)
  end
end
