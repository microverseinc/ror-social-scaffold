class FriendshipsController < ApplicationController
    before_action :authenticate_user!

    def send_request
        friend = User.find(params[:id])

        @friendship= Friendship.new(user_id:current_user.id,
             friend_id: friend.id)
        if @friendship.save
            flash[:notice] = "friend request has been sent"
            redirect_to users_path
        else
            flash[:alert] = "somethings went wrong"
            redirect_to users_path
        end
    end


    def accept_friend
        friend= User.find(params[:id])

        if current_user.confirm_friendship(friend)
            flash[:notice]="now  you are friend with #{ friend.name }"
        else
            flash[:notice]="something went wrong"
        end
        redirect_to users_path
    end

    def destroy_friendship
        friend = User.find(params[:id])
        friendship = Friendship.find do |friendship|
            (friendship.user_id == current_user.id && friendship.friend_id == friend.id)||
            (friendship.user_id == friend.id && friendship.friend_id == current_user.id)
        end
        friendship.destroy if friendship
        redirect_to users_path
    end 

end