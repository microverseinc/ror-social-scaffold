class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(sender_id: current_user.id)
    @friendship.reciever_id = params[:user_id]
    @friendship.status = false

    if @friendship.save
      redirect_to users_path, notice: 'Friend request was successfully sent.'
    else
      redirect_to users_path, alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end

  def update
  end

  def index
  end

  def destroy
  end
end
