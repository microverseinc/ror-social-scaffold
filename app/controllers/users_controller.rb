class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def invite
    receiver = User.find(params[:receiver])
    invitation = current_user.invitations.build(friend: receiver)
    invitation.save!
  end
end
