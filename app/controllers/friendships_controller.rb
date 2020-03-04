class FriendshipsController < ApplicationController

  def create
    flash.now[:alert] = 'Invitation sent'
    render controller: 'user', action: 'index'
  end
end
