class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @request = current_user.requests_send_unconfirmed.build
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
