class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.joins(:inviter).where(invitee_id: current_user.id)
  end

  def create
    @friendship = Friendship.new(friendship_params) unless check_invitation(current_user,
                                                                            params[:friendship][:invitee_id])
    invitee_path = "/users/#{params[:friendship][:invitee_id]}"

    if @friendship.save
      redirect_to invitee_path, notice: 'Friend request was sent.'
    else
      redirect_to invitee_path, notice: 'Friend request cannot be sent.'
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @inverse_friendship = Friendship.new(inviter_id: @friendship.invitee_id,
                                         invitee_id: @friendship.inviter_id, status: true)

    if @friendship.update(friendship_params) && @inverse_friendship.save
      redirect_to friendships_path, notice: 'You have succesfully accepted this request.'
    else
      render friendships_path, status: :unprocessable_entity
    end
  end

  def destroy
    friendship = Friendship.find_by(friendship_params)
    if friendship
      friendship.destroy
      redirect_to friendships_path, notice: 'Friendship request rejected.'
    else
      redirect_to friendships_path, alert: 'Please try again.'
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:inviter_id, :invitee_id, :status)
  end
end
