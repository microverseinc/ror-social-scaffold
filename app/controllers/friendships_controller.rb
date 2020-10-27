class FriendshipsController < ApplicationController

    def create
        current_user.friendships.create!(friendship_params)
        redirect_to users_path
    end

    def destroy
        another_user = User.find_by(params[:id])
        current_user.friends.delete(another_user)
        redirect_to users_path
    end

    def update
        Friendship.find(params[:id]).update(confirm: true)
    end    

    private

    def friendship_params
        params.require(:friendship).permit(:friend_id)
    end
end
