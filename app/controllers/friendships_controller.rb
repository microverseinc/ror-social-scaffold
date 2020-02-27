class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(sender_id: current_user.id)
    @friendship.reciever_id = params[:user_id]
    @friendship.status = false

    if @friendship.save
      redirect_to request.referrer, notice: 'Friend request was successfully sent.'
    else
      redirect_to request.referrer, alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.status = true

    if @friendship.save
      redirect_to user_path(current_user.id), notice: 'Friend request was successfully confirmed'
    else
      redirect_to user_path(current_user.id), alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end

  def index
    @friendships = current_user.friendships
    @inverse_friendships = current_user.inverse_friendships
  end

  def destroy
    @friendship = Friendship.find_by(reciever_id: current_user.id, sender_id: params[:user_id])

    if @friendship.destroy
      redirect_to user_path(current_user.id), notice: 'Friend request declined, we won\'t inform the sender'
    else
      redirect_to user_path(current_user.id), alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end
end
