class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friends = current_user.friends
    @pending_inviter_friends = current_user.pending_inviter_friends
    @pending_invitee_friends = current_user.pending_invitee_friends
  end
end
