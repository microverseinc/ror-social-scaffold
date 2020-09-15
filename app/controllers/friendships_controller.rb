class FriendshipsController < ApplicationController
  def show
    current_user.friendships.build(friend_id: params[:id])
    current_user.save
    redirect_to users_path
  end

  def create
    current_user.friendships.build(friend_id: params[:id])
    current_user.save
    redirect_to users_path
  end

  def update
    fs = Friendship.find_by(user_id: params[:id], friend_id: params[:friend_id])
    if params[:act].eql? 'accept'
      fs&.update(status: 'connected')
    else
      fs&.destroy
    end

    redirect_to users_path
  end

  def id_param
    params.require(:id).permit(:id)
  end
end
