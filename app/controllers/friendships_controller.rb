class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:id])
    @friendship = Friendship.new(user_id: current_user.id, friend_id: @user.id)
    if @friendship.save
      flash.now[:notice] = 'everthing good'
      redirect_to user_path(@user)
    else
      flash.now[:danger] = 'something went wrong'
    end
  end
end
