class FriendshipsController < ApplicationController
    def new
        @friendship = Friendship.new
    end

    def create
        @friendship = current_user.friendships.build(event_params)    
    end

    def send_requests 
        # @friendship = Friendship.find(params[:id])
        if @friendship.friend_requests.include?(friend_id)
          redirect_to @friendship, alert: 'Request was already sent'
        else
          @friendship.friend_requests << friend
          redirect_to @friendship, notice: 'Friend request sent successfuly!'
        end
    end

    def confirm_requests 
        # @friendship = Friendship.find(params[:id])        
          @friendship.friend_requests << friend
          redirect_to @friendship, notice: 'Friend request sent successfuly!'
        end
    end   
 

    private

    def set_friendship
        @friendship = Friendship.find(params[:id])
    end

    def event_params
        params.require(:friendship).permit(:user_id, :friend_id, :confirmed)      
    end

end 