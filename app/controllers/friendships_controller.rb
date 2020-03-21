class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user?, only: %i[edit delete show]

  def index
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:id])
    redirect_to friendship_path(@friendship) and return if friendship_exists?
    @friendship = Friendship.new(user_id: current_user.id, friend_id: @user.id)
    if @friendship.save
      flash.now[:notice] = 'everthing good'
      redirect_to user_path(@user)
    else
      flash.now[:danger] = 'something went wrong'
    end
  end

  def show
    @friendship = Friendship.find(params[:id])
    @user = @friendship.user
    @friend = @friendship.friend
  end

  def edit
    @friendship = Friendship.find(params[:id])
    @friend = @friendship.friend
    @friend.confirm_friend(@friendship.user)
    redirect_to user_friendships_path(@friend)
  end

  def delete
    @friendship = Friendship.find(params[:id])
    @user = @friendship.friend
    @friendship.delete
    redirect_to user_friendships_path(@user)
  end

  private

  def friendship_exists?
    @friendship = Friendship.all.select do |fsh|
      (fsh.user_id == current_user.id && fsh.friend_id == @user.id) ||
        (fsh.user_id == @user.id && fsh.friend_id == current_user.id)
    end
    !@friendship.empty?
  end

  def correct_user?
    @friendship = Friendship.find(params[:id])
    return nil if current_user.id == @friendship.friend.id

    redirect_to user_friendships_path(current_user.id)
  end
end
