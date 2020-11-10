class FriendshipsController < ApplicationController
<<<<<<< HEAD
  def new
    # @friendship = Friendship.new
  end

  def create
    @friend = User.find_by(id: params[:friend_id])
    flash[:danger] = 'Invalid friend request' unless @friend
    if current_user.friend?(@friend)
      flash[:alert] = "You're already friends with this user"
    elsif current_user.pending_friends.include?(@friend)
      flash[:alert] = 'Friend request previously sent to this user'
    elsif current_user.send_request(@friend.id)
      flash[:success] = 'Friend request sent!'
    else
      flash[:danger] = 'Friend request not sent'
    end
    redirect_back
  end
end
=======

    def new
        @friendship = Friendship.new
    end

    def create
        @friendship = current_user.Friendship.new(friendship_params)
        if save
            redirect_to root_path, notice:'You have sent a friend request'
        else
            redirect_to root_path, notice: "An error happened and you can't send friend request."
        end
    end



    private

    def friendship_params
        params.require(:friendship).permit(:user_id,:friend_id)
    end
end
>>>>>>> 2aae3c597586feca647bd7ff0e290f057fa0bdf3
