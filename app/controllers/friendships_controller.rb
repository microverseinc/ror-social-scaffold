class FriendshipsController < ApplicationController
    def index
    @friendship =current_user.Friendship.all  
    end
    def create
        @user=User.find(params[:user_id])
        @friendships= current_user.friendships.new
        @friendships.friend_id= @user.id
        @friendships.requester_id =current_user.id
        @friendships.save

    end
    def destroy
        @user=User.find(params[:user_id])
        @user.each(&:destroy)
    
    end
    def update
        @user=User.find(params[:user_id])
        current_user.confirm_friend(@user) 
        
          

    end
end
