class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.exclude_current_user(current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def invite
    invitation = current_user.friend_requests.build(friend_id: params[:user_id])
    if User.check_request(current_user, params[:user_id])
      flash.notice = 'You already have a pending invitation'
      redirect_to users_path
    elsif invitation.save
      redirect_to users_path, notice: 'Your invitation has been sent!'
    end
  end

  def accept
    request = FriendRequest.find_by(user_id: params[:user_id], friend_id: current_user.id)
    request.confirmed = true
    request.save
    redirect_to user_path(current_user), notice: 'Invitation accepted successfully'
  end

  def reject
    request = FriendRequest.find_by(user_id: params[:user_id], friend_id: current_user.id)
    request.destroy

    redirect_to users_path, notice: 'Invitation has been declined'
  end
end
