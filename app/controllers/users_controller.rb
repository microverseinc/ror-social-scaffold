class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friends = Friendship.where('friend_id = ? and status = ?', current_user.id, true)
    @friends.all.map(&:user_id)
    @all_friends = []
    @friends.each { |u| @all_friends << User.find(u.user_id) }
  end

  def confirm
    user = User.find(params[:friend_id])
    friend = Friendship.where('friend_id = ? and user_id = ?', current_user.id, user.id).first
    friend.status = true
    if friend.save
      @add_friend = Friendship.new(user_id: current_user.id, friend_id: user.id, status: true)
      @add_friend.save
      redirect_to user_path(current_user), notice: 'Accepted'
    else
      redirect_to user_path(current_user), alert: 'Rejected'
    end
  end

  def destroy
    user = User.find(params[:friend_id])
    friend1 = Friendship.where('friend_id = ? and user_id = ?', user.id, current_user.id).first
    friend2 = Friendship.where('friend_id = ? and user_id = ?', current_user.id, user.id).first
    if !friend1.nil?
      if friend1.delete
        redirect_to user_path(current_user), notice: 'Rejected'
      else
        redirect_to user_path(current_user), alert: 'Failed'
      end
    elsif !friend2.nil?
      if friend2.delete
        redirect_to user_path(current_user), notice: 'Rejected'
      else
        redirect_to user_path(current_user), alert: 'Failed'
      end
    end
  end
end
