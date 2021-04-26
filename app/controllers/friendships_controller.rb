class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friendship_params)

    # use save to check the validation of the friendship, true = valid, false = invalid
    if @friendship.save
      redirect_to users_path, notice: 'Friend Invitation has been sent.'
    else
      render :index, alert: "Friendship isn't validated, friendship couldn't be requested"
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update(status: true)
    @friendship = Friendship.create(user_id: @friendship.friend_id, friend_id: @friendship.user_id, status: true)
    redirect_to user_path(current_user), notice: 'Friendship Accepted'
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to user_path(current_user), notice: 'Friendship rejected'
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id, :status)
  end
end
