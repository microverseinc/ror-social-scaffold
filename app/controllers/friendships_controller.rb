class FriendshipsController < ApplicationController
    before_action :authenticate_user!
    def index
        @request=Friendship.where(user_id:current_user.id,status:true)
    end

    def create
        @user=User.find(params[:user_id])
        current_user.friendships.create(friend:@user)
        redirect_to request.referrer,notice:"Friend request succesffuly sent"
    end



end
