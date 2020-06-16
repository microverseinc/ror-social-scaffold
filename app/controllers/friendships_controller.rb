class FriendshipsController < ApplicationController
    before_action :authenticate_user!
    def index
        @request=Friendship.where(user_id:current_user.id,status:true)
    end

end
