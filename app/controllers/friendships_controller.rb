class FriendshipsController < ApplicationController
    before_action :find_friendship, only: %i[destroy update]

    def index; end
  
    def create
      @friendship = Friendship.create(friendship_params)
      if @friendship.save
        flash.now[:success] = 'Friendship successfully created'
        redirect_to users_path
      else
        flash[:error] = 'Something went wrong'
        render 'new'
      end
    end
  
    def update
      friend = User.find(@friendship.user_id)
      @friendship.update_attributes(confirmed: true)
      current_user.confirm_friend(friend)
      redirect_to friendships_path
    end
  
    def destroy
      @friendship.destroy
      redirect_to friendships_path
    end
  
    private
  
    def find_friendship
      @friendship = Friendship.find(params[:id])
    end
  
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id, :status)
    end
end
