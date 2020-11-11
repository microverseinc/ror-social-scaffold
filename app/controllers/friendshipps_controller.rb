class FriendshippsController < ApplicationController
  include FriendshippsHelper
        def create
          return if friend_request_received?(User.find(params[:friend_id]))
          return if friend_request_sent?(User.find(params[:friend_id]))
         
          @friendship = current_user.friendshipps.build(friend_id: params[:friend_id])
          if @friendship.save
            flash[:notice] = 'Request sent'
            redirect_to root_path
          else
            flash[:notice] = 'Unable to send request'
          end
      
        end
      
      
end
