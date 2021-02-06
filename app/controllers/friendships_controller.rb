class FriendshipsController < ApplicationController
    # before_action :set_friendship

    # def new
    #     @friendship = Friendship.new
    # end 
    
    def create(user_id)
      # @friendship = Friendship.new(friendship_params)
      @friendship = current_user.friendships.build(friend_id: user_id)
      
      if @friendship.save
        redirect_to root_path,
                    notice: 'Friend request sent succussfully!'
      else
        render 'users/index'
      end
    end

    def update
      
    end 
  
    private

    def friendship_params
        params.require(:friendship).permit(:user_id, :friend_id)      
    end

end 