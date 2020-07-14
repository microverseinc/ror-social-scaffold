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
    invitation = current_user.friend_requests.build(friend_id: params[:user_id])
    if invitation.save
      redirect_to users_path, notice: "Your invitation has been sent!"
    end
  end
end
