  class FriendshipsController < ApplicationController

   before_action :authenticate_user!
    before_action :appoint_friend, only: %i[create destroy]

def index
end

    def create
        if @friendship.nil?
        @request =friendship.new(user_id: current_user.id, friendy_id: params[:user_id])

        if @request.save
            flash.notice = "succesfully sent a request"
            redirect_back(fallback_location: root_path)
        else
            render :new 
      end
    else
        flash.notice = "hello! there is a pending request for this user"
        redirect_back(fallback_location: root_path)
    end
end
    
      # Users who have yet to confirme friend requests
      def update
        @user = user.find(params[:user_id])
        current_user.confirm_friend(current_user,@user)
        flash.notice = 'yipee,i accept you!'
        redirect_back(fallback_location: root_path)
      end
    
      # Users who have requested to be friends
      def destroy
        @friendship.destroy
        redirect_back(fallback_location: root_path)
      end
    
     private

     def appoint_friend
        @friends = Friend.find_by(user_id: params[:user_id], friendy_id: current_user.id) ||
        Friend.find_by(user_id: current_user.id, friendy_id: params[:user_id])
     end

  end