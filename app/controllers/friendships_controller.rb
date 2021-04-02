class FriendshipsController < ApplicationController

    def create
        @friendship = Friendship.create(friend_id: params[:friend_id], user_id: current_user.id, confirmed: false)
        redirect_to "/users/#{params[:friend_id]}" if @friendship.save
    end
      
    private    
    # Only allow a list of trusted parameters through.
    def friendships_params
        params.require(:friendships).permit(:user_id, :friend_id, :confirmed)
    end    
end
