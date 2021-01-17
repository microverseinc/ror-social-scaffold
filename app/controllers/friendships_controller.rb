class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    #  @current_friend = User.find(params[:friendship][:friend_id])
    @friendship = current_user.friendships.build(params_friendship)
    if @friendship.save
      flash[:notice] = 'Friendship was saved correctly.'
      redirect_to users_path
    else
      render :create
    end
  end

  def update
    @friendship = Friendship.where(friend_id: [current_user, params[:id]], user_id: [current_user, params[:id]]).first
    @friendship.update(confirmed: true)
    if @friendship.save
    flash[:notice] = 'Friendship was confirmed correctly.'
    redirect_to users_path
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy

    redirect_to users_path
  end

  private

  def params_friendship
    params.require(:friendship).permit(:friend_id,:user_id)
  end
end
