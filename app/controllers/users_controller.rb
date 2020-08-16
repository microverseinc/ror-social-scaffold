class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @pending_invitations = current_user.pending_invites
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
