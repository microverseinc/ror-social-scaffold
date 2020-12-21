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
  
    def destroy
      @friendship.destroy
      redirect_to friendships_path
    end

    def accept
      @friendship = Friendship.find_by(friend_id: params[:friend_id], user_id: params[:user_id])
      inverse_friendship = Friendship.create(friend_id: params[:user_id], user_id: params[:friend_id], status: true)
      @friendship.update status: true
      redirect_to users_path, notice: 'Friendship accepted successfully'
    end
  
    def reject
      @friendship = Friendship.find_by(friend_id: params[:friend_id], user_id: params[:user_id])
      @friendship = Friendship.find_by(friend_id: params[:user_id], user_id: params[:friend_id]) if @friendship.nil?
      @friendship.destroy
      redirect_to users_path, notice: 'Friendship was rejected'
    end
  
    private
  
    def find_friendship
      @friendship = Friendship.find(params[:id])
    end
  
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id, :status)
    end

end
