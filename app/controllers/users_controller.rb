class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @all_users = User.where.not(id: current_user.id)
    @friends = current_user.friends
    @recieved = current_user.recieved_requests
    @sent = current_user.sent_requests
  end
end
