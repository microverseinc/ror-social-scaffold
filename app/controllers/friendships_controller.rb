class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def new; end

  def create
    @user = User.find(params[:id])
    @friendship = current_user.friendships.new(user_id: @user.id, status: false)
    if @friendship.save
      redirect_to users_path, notice: "Friend request sent to #{@user.name}"
    else
      redirect_to users_path, alert: "Could not send request now, try again"
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship.destroy
      redirect_to users_path, notice: 'Request declined'
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :status)
  end
end
