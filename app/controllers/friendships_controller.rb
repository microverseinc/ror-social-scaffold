class FriendshipsController < ApplicationController
    def send_invitation
        if current_user.send_request(params[:user_id])
          redirect_to users_path, notice: 'Friend request sent'
        end
    end

    def confirm_request
        if current_user.confirm_friend(params[:user_id])
          redirect_to users_path, notice: 'Friend request accepted'
        end
    end
end
