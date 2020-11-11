class FriendshippsController < ApplicationController
    
        def create
          #@friendship = current_user.friendshipps.build(friend_id: params[:user_id])
          @friendship = current_user.friendshipps.build(friend_id: params[:friend_id])
          if @friendship.save
            flash[:notice] = 'Request sent'
            redirect_to root_path
          else
            flash[:notice] = 'Unable to send request'
          end
      
        end
      
      
end
