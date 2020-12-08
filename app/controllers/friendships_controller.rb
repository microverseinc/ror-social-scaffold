class FriendshipsController < ApplicationController
    def index
    @friendship =current_user.Friendship.all  
    end
    def create
        @user=User.find(params[:user_id])
        @friendship= current_user.friendship.new
        @friendship.friend_id= @user.id
        @friendship.requester_id =current_user.id
        @frienship.save

    end
    def destroy

    end
    def update
    end
end
