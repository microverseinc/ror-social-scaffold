
class FriendshipsController < ApplicationController
  def index
    @my_friends = current_user.friends
  end

  def create
    @friendship = current_user.friendships.build(params_friendship)
    if @friendship.save
      flash[:notice] = 'Friendship was saved correctly.'
      redirect_to users_path
    else
      render :create
    end
  end

  def update
    user = User.find(params[:id])
    if current_user.friend_requests.include?(user)
      current_user.confirm_friend(user)
      flash[:notice] = 'You are now friends.'
      redirect_to users_path
    end
  end

  def destroy
    if Friendship.exists?(params[:id])
     @friendship=Friendship.find(params[:id])
      @friendship.destroy
    else
      @friendship = Friendship.where(friend_id: [current_user, params[:id]], user_id: [current_user, params[:id]]).first
      @friendship.destroy
    end

    redirect_to users_path
  end

  private

  def params_friendship
    params.require(:friendship).permit(:friend_id, :user_id)
  end
end

