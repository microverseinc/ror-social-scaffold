class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
     @current_friend = User.find(params[:friendship][:friend_id])
    @friendship = current_user.friendships.build(params_friendship)
    if @friendship.save
      flash[:notice] = 'Friendship was saved correctly.'
      redirect_to users_path
    else
      render :create
    end
  end

  def update
    user = User.find(params[:user_id])
    if current_user.friend_requests.include?(user)
      current_user.confirm_friend(user)
      flash[:notice] = 'Friendship was confirmed correctly.'
      redirect_back(fallback_location: user_path)
    else
      flash[:notice] = 'Friendship was not modified.'
      render :update
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.delete

    redirect_to users_path
  end

  private

  def params_friendship
    params.require(:friendship).permit(:friend_id,:user_id)
  end
end
