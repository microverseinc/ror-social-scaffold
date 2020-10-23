class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.includes(:friendships)
    @users_requested = []
    @users_unrequested = []
    @users_invites = []
    @users_friends = []
    lists_of_users
  end

  def lists_of_users
    @users.each do |user|
      if user.id == current_user.id
        next
      elsif current_user.friendships.where(friend_id: user.id, status: false).exists?
        @users_requested << user
      elsif user.friendships.where(friend_id: current_user.id, status: false).exists?
        @users_invites << user
      elsif user.friendships.where(friend_id: current_user.id, status: true).exists? || current_user.friendships.where(friend_id: user.id, status: true).exists?
        @users_friends << user
      else
        @users_unrequested << user
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
