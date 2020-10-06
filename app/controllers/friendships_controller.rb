class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def new; end

  def create
    puts params.inspect
    @user = User.find(params[:invitee_id])
    @friendship = current_user.friendships.new
    @friendship.invitee_id = @user.id
    @friendship.status = false
    if @friendship.save
      redirect_to users_path, notice: "Friend request sent to #{@user.name}"
    else
      redirect_to users_path, alert: 'Could not send request now, try again'
    end
  end

  def destroy
    @friendship = current_user.inverse_friendships.find(:id)
    redirect_to users_path, notice: 'Request declined' if @friendship.destroy
  end
end
