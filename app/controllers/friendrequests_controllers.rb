class FriendrequestsController < ApplicationController
    def index
      @friends = current_user.friends
    end
  
    def new; end
  
    def create
      User.find(params[:user_id]).send_friend_request(User.find(params[:friend_id]))
      redirect_to users_path
    end
  
    def edit
      Friendrequest.find(params[:id]).update(confirmed: true)
      redirect_to users_path
    end
  
    def destroy
      Friendrequest.find(params[:id]).destroy
      redirect_to users_path
    end
  end
  