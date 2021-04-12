class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @friendships = Friendship.all
  end

  def create
    puts friendship_params
    @friendship = Friendship.new(friendship_params)

    if @friendship.save
      redirect_to request.referrer, alert: 'Friendship request successfully sent.'
    else
      redirect_to request.referrer, alert: 'Friendship request NOT sent.'
    end
  end

  def update
    respond_to do |format|
      if @friendship.update(friendship_params)
        redirect_to request.referrer, alert: 'Friendship request successfully accepted.'
      else
        redirect_to request.referrer, alert: 'Friendship request NOT accepted.'
      end
    end
  end

  def destroy
    friendship = Friendship.find_by(user_id: params[:id].to_i, friend_id: current_user.id.to_i)
    second_record = Friendship.find_by(user_id: current_user.id.to_i, friend_id: params[:id].to_i)
    if friendship.destroy && second_record
      current_user.friend_requests.delete(friendship)
      redirect_to request.referrer, alert: 'Friendship request declined.'
    else
      redirect_to request.referrer, alert: 'Friendship request could NOT be declined'
    end
  end

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :confirmed)
  end
end
