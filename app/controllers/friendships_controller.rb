class FriendshipsController < ApplicationController

    def create
         @friendship = current_user.friendships.new(friend_id: params[:friend_id])
         @friendship.confirmed = false
         if @friendship.save
            redirect_to users_path, notice: 'You send a friend request.'
          else
            redirect_to users_path, alert: @friendship.errors.full_messages.join('. ').to_s
          end
    end


    private
  def friendships_params
    params.require(:friendship).permit(:friend_id, :user_id, :confirmed)
  end
end
