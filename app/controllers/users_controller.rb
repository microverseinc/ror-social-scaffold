class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.where('id != ?', current_user.id)
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @mutual = @user.friends & current_user.friends
  end

  def accept
    @user = User.find(params[:user_id])
    current_user.confirm_friend(@user)
    @friendship = Friendship.create(user_id: current_user.id, friend_id: params[:user_id])
    @user.confirm_friend(current_user)
    redirect_to users_path, notice: 'you are now friends with ' + @user.name.to_s
  end

  def reject
    @user = User.find(params[:user_id])
    current_user.decline_friend(@user)
    redirect_to users_path
  end

  def remove
    @friendship1 = Friendship.find_by(user_id: current_user.id, friend_id: params[:user_id])
    @friendship2 = Friendship.find_by(user_id: params[:user_id], friend_id: current_user.id)
    @friendship1.destroy
    @friendship2.destroy
    redirect_to users_path
  end

  def invite
    @friendship = Friendship.new(user_id: current_user.id, friend_id: params[:friend_id])
    @friendship.save
    redirect_to users_path
  end

  def cancel
    @friendship = Friendship.find_by(user_id: current_user.id, friend_id: params[:friend_id])
    @friendship.destroy
    redirect_to users_path
  end

  private

  def friendship_params
    params.require(:friendships).permit(:user_id, :friend_id, :confirmed)
  end
end
