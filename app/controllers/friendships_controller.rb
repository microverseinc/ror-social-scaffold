class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @sent_friendships = current_user.sent_friendships
    @received_friendships = current_user.received_friendships
  end

  def new
    @friendship = Friendship.new
  end

  def show
    set_friendship
  end

  def edit
    set_friendship
  end

  def create
    @friendship = Friendship.new(friendship_params)

    if @friendship.save
      redirect_to request.referrer, alert: 'Friendship request successfully sent.'
    else
      redirect_to request.referrer, alert: 'Friendship request NOT sent.'
    end
  end

  def update
    if Friendship.update(friendship_params)
      redirect_to request.referrer, alert: 'Friendship request successfully accepted.'
    else
      redirect_to request.referrer, alert: 'Friendship request NOT accepted.'
    end
  end

  def destroy
    @friendship = set_friendship
    if @friendship.destroy
      redirect_to request.referrer, alert: 'Friendship request declined.'
    else
      redirect_to request.referrer, alert: 'Friendship request could NOT be declined'
    end
  end

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :confirmed)
  end
end
