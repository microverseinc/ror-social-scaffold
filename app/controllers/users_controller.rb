class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def request_friend
    request = current_user.friendships.build(friend_id: params['id'], status: false)
    request.save
    flash[:notice] = 'Friend Request Successfully sent'
    redirect_to users_path
  end

  
end
