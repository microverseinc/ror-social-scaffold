class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users2 = User.includes(:friendships)
    @users_requested = []
    @users_unrequested = []
    @users_invites = []
    @users2.each do |user|
      if current_user.friendships.where(friend_id: user.id).exists?
        @users_requested << user
      elsif user.friendships.where(friend_id: current_user.id).exists?  
        @users_invites << user
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
