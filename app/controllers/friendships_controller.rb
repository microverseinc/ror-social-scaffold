class FriendshipsController < ApplicationController
    def send_invitation
        if current_user.send_invitation(params [:user_id])
            flash.notice = "Your friend request has been sent."
            redirect_to users_path
        else
            flash.alert = "Ooops!! an error has occured" 
        end
    end

    def 

    end
end
