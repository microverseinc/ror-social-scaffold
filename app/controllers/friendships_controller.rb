class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def new; end

  def create
    @user = User.find_by(id: params[:invitee_id])
    @friendship = current_user.friendships.new(friendship_params)
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
    params.permit(:invitee_id)
  end
end
