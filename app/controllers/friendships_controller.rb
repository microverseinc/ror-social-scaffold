class FriendshipsController < ApplicationController
    def new
        @friendship = Friendship.new
    end

    def create
    end

    def show
    end

    def destroy
    end

    def update
    end


    private 
    def friendship_params
        params.require(friendship).permit(:user_id, :friend_id, :confirmed)
    end

end
