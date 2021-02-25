class FriendshipsController < ApplicationController
  def new; end

  def create
    @friendship = current_user.friendships.find_by_friend_id(params[:friend_id])
    @inverse_friendship = current_user.inverse_friendships.find_by_user_id(params[:friend_id])
    if !(@friendship || @inverse_friendship)
      @friendship = current_user.friendships.build(friend_id: params[:friend_id])
      if @friendship.save
        redirect_to users_path,
                    notice: 'Sent Friend Request'
      else
        redirect_to users_path,
                    alert: 'Friend Request Not Sent'
      end

    else
      redirect_to users_path,
                  alert: 'Friendship is Pending'
    end
  end

  def update
    @friendship = Friendship.find_by_id(params[:friendship_id])
    if !@friendship.nil?
      @friendship.update({ status: true })
      redirect_to current_user,
                  notice: "You added #{@friendship.user.name} as your friend"
    else
      redirect_to current_user,
                  alert: 'Something went wrong'
    end
  end

  def destroy
    @friendship = Friendship.find_by_id(params[:friendship_id])
    if @friendship.destroy
      redirect_to root_path,
                  notice: 'Friend rejected!'

    else
      redirect_to root_path,
                  alert: 'Something went wrong'
    end
  end
end
