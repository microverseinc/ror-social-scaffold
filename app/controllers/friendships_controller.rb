class FriendshipsController < ApplicationController
  def new
    @request = Friendship.new
    create
  end

  def create
    @request = Friendship.create(friendship_params)
    if @request.save
      redirect_to users_path, notice: 'Friendship request sent!'
    else
      redirect_to users_path
    end
  end

  def edit
    update
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @user = User.find(@friendship.user_id)
    @inverse_friendship = @user.inverse_friendships.find_by(user_id: @friendship.friend_id)
    Friendship.delete(@friendship.id) if @inverse_friendship.nil?
    Friendship.delete([@friendship.id, @inverse_friendship.id]) unless @inverse_friendship.nil?

    redirect_to users_path, notice: 'Friendship request deleted!'
  end

  def update
    @friendship = Friendship.where(accept_friend_params)
    if @friendship.confirm_friend(params[:user_id], params[:friend_id])
      redirect_to users_path, notice: 'You accepted the request!'
    else
      redirect_to users_path
    end
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id, :confirmed)
  end

  def accept_friend_params
    flag = { 'confirmed' => false }
    params.permit(:user_id, :friend_id, flag)
  end
end
