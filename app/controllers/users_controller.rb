class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show create_friendship accept decline]

  def index
    @users = User.all
  end

  def show
    @posts = @user.posts.ordered_by_most_recent
  end

  def accept
    current_user.confirm_friend(@user)
    redirect_to request.referrer, notice: 'Confirmed friend request'
  end

  def decline
    user = User.find(params[:data])
    friendship = @user.inverse_friendships.find { |f| f.user == user }
    friendship.destroy
    redirect_to request.referrer, notice: 'Declined friend request'
  end

  def create_friendship
    current_user.friendships.create(user_id: current_user.id, friend_id: @user.id, confirmed: false)
    redirect_to request.referrer, notice: 'Sent friend request'
  end

  def set_user
    @user = User.find(params[:id])
  end
end
