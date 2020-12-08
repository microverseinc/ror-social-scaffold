class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friendships.all
  end

  def create
    @friendship = current_user.friendships.build(receiver_id: params[:id], confirmed: false)
    if @friendship.save
      redirect_to users_path, notice: 'You just sent a friendship request'
    else
      redirect_to users_path, alert: 'You ALREADY sent a friendship request'
    end
  end

  def destroy
    @friendship = current_user.confirmed_friendships.find_by(receiver_id: params[:id])
    @friendship.destroy
    redirect_to users_path, notice: 'Friendship has been deleted'
  end

end
