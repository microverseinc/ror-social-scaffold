class FriendshipsController < ApplicationController
    def send_invitation
        if current_user.send_request(params[:user_id])
          redirect_to users_path, notice: 'Friend request sent'
        end
    end
end
