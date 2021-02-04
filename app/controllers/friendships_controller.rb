class FriendshipsController < ApplicationController
    def new
        @friendship = Friendship.new
    end

    def create
        @friendship = current_user.friendships.build(event_params)    
    end

    def send_request
        # @friendship = Friendship.find(params[:id])
        if @friendship.friend_requests.include?(friend_id)
          redirect_to @friendship, alert: 'Request was already sent'
        else
          @friendship.friend_requests << friend
          friend.pending_friends << current_user
          redirect_to @friendship, notice: 'Friend request sent successfuly!'
        end
    end

    def confirm_request
        # @friendship = Friendship.find(params[:id])        
          @friendship.confirm_friends << friend
          redirect_to @friendship, notice: 'Friend request sent successfuly!'
        end
    end   

    def destroy
        friend_requester = User.find(params[:friend_id])
        friend_request = friend_requester.friendships.find(params[:id])
        friendship = current_user.friendships.find_by_friend_id(friend_requester.id)
        if friendship.nil?
          friend_request.destroy
          flash[:notice] = "Removed friend request."
        else
          friendship.destroy
          friend_request.destroy
          flash[:notice] = "Removed friendship."
        end
        redirect_to current_user
    end 

    private

    def set_friendship
        @friendship = Friendship.find(params[:id])
    end

    def event_params
        params.require(:friendship).permit(:user_id, :friend_id, :confirmed)      
    end

end 