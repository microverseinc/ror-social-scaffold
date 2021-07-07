class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent

    @approved_friends = current_user.sent_requests
    @received_invites = current_user.inverse_friendships
  end
end
