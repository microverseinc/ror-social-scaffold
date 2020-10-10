class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def new; end

  def create
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
    @invitor = User.find(params[:invitor_id])
    @friendship = current_user.inverse_friendships.where(invitor_id: @invitor.id).first
    redirect_to users_path, notice: 'Friend declined' if @friendship.destroy
  end

  def accept
    @invitor = User.find(params[:invitor_id])
    @friendship = current_user.find_friendship(@invitor)
    if @friendship.update(status: true)
      redirect_to users_path, notice: "You are now friends with #{@invitor.name}"
    else
      redirect_to users_path, alert: 'Ops! something went wrong'
    end
  end

  def remove; end
end
