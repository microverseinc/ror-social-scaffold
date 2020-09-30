class FriendshipsController < ApplicationController

    def new
        @friendship = Friendship.new
    end

    def create
        @friendship = current_user.Friendship.new(friendship_params)
        if save
            redirect_to root_path, notice:'You have sent a friend request'
        else
            redirect_to root_path, notice: "An error happened and you can't send friend request."
        end
    end



    private

    def friendship_params
        params.require(:friendship).permit(:user_id,:friend_id)
    end
end