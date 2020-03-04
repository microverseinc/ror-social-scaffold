class FriendshipsController < ApplicationController

  def create
    flash.now[:alert] = 'Invitation sent'
    render controller: 'user', action: 'index'
  end

  def update
    friendship = Friendship.find(params[:id])
    friendship.update(confirmed: true)
    render 'users/index'
  end
end
