
class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
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
    # friendship = Friendship.where(friend_id: [current_user, params[:id]], user_id: [current_user, params[:id]]).first
    user = User.find(params[:id])
    if current_user.friend_requests.include?(user)
      current_user.confirm_friend(user)
      flash[:notice] = 'You are now friends.'
      redirect_to users_path
    end
  end

  def destroy
    if Friendship.exists?(params[:id])
     !@friendship=Friendship.find(params[:id])
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

