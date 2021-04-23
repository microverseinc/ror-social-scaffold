class FriendshipsController < ApplicationController
    def create
      @friendship = current_user.friendships.build(friendship_params)
  
      # use save to check the validation of the friendship, true = valid, false = invalid
      if @friendship.save
        redirect_to users_path, notice: 'Friend Invitation has been sent.'
      else
        render :index, alert: "Friendship isn't validated, friendship couldn't be requested"
      end
    end
  
    private
  
    def friendship_params
      params.require(:friendship).permit(:friend_id, :status)
    end
  end