class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def add_friend
    @user = current_user
    new_friend = current_user.friendship.build(friend_id: @user.id)
    if new_friend.save
      flash[:succes] = 'Friend request sended'
      redirect_to user_path(user)
    else
      flash[:danger] = 'Something went wrong'
    end
  end
end
