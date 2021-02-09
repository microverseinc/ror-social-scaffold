class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friend_requests = @user.friend_requests
    @pending_friends = @user.pending_friends
    @friends = @user.friends
  end

  def create_friendship
    @user = User.find(params[:id])

    user_friendid = if current_user.id < @user.id
                      "#{current_user.id}-#{@user.id}"
                    else
                      "#{@user.id}-#{current_user.id}"
                    end
    friendship = current_user.create_friendship(@user.id, user_friendid)

    if friendship
      redirect_to root_path, notice: 'You successfully sent friend request!'
    else
      redirect_to root_path, notice: 'Invalid Request!'
    end
  end

  def delete_friends
    @user = User.find(params[:id])

    user_friendid = if current_user.id < @user.id
                      "#{current_user.id}-#{@user.id}"
                    else
                      "#{@user.id}-#{current_user.id}"
                    end
    current_user.delete_friend(user_friendid)
    redirect_to root_path, notice: 'You successfully deleted friend!'
  end

  def confirm_friends
    @user = User.find(params[:id])
    current_user.confirm_friend(@user)
    redirect_to root_path, notice: 'You successfully accepts friend!'
  end
end
