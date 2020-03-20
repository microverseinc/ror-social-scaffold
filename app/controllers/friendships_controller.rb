class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
  end

  def create
    @friendship = Friendship.new(user_id: current_user.id, friend_id: params[:id])
    if @friendship.save
      flash.now[:notice] = 'everthing good'
      render users_path(@user)
    else
      flash.now[:danger] = 'something went wrong'
    end
  end
end
