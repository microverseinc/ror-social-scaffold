class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show create_friendship accept decline]

  def index
    @users = User.all
  end

  def show
    @posts = @user.posts.ordered_by_most_recent
  end

  def create_friendship
    current_user.friendships.create(user_id: current_user.id, friend_id: @user.id, confirmed: false)
    redirect_to request.referrer, notice: 'Friend request sent'
  end

  def accept
    current_user.confirm_friend(@user)
    redirect_to request.referrer, notice: 'Friend request confirmed'
  end

  def decline
    user = User.find(params[:data])
    friendship = @user.inverse_friendships.find { |fship| fship.user == user }
    friendship.destroy
    redirect_to request.referrer, notice: 'Friend request rejected'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
