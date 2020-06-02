class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :my_self?, only: :add_friend

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def add_friend
    @friend = User.find_by(id: params[:id])
    new_friend = current_user.friendship.build(friend_id: @friend.id)
    if new_friend.save
      flash[:succes] = 'Friend request sended'
      redirect_to user_path(friend)
    else
      flash[:danger] = 'Something went wrong'
    end
  end
end
