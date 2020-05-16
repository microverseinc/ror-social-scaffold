class FriendshipsController < ApplicationController
    def create
        current_user.friendships.create(friendship_params)
        redirect_to users_path
    end

    def destroy
        user = User.find(params[:user_id])
        current_user.friends.delete(user)
        redirect_to users_path
    end

    def friendship_params
        params.require(:friendship).permit(:friend_id, :status)
    end

end
