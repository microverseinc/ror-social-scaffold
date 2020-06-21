class FriendshipsController < ApplicationController
  def show; end

  def new
    @friendship = Friendship.new
  end

  # rubocop:disable Style/ConditionalAssignment
  def create
    @friendship = Friendship.new(friendship_params)
    if @friendship.save
      flash[:notice] = 'Friendship request sent successfully'
    else
      flash[:notice] = 'Friendship request couldn\'t be sent'
    end
    friendship_redirect
  end
  # rubocop:enable Style/ConditionalAssignment

  def update
    Friendship.find(params[:id]).update_attribute(:status, true)
    flash[:notice] = 'Friendship has been accepted'
    friendship_redirect
  end

  def destroy
    Friendship.find(params[:id]).destroy
    flash[:notice] = 'Friendship has been rejected'
    friendship_redirect
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id, :user_id, :id)
  end

  def friendship_redirect
    redirect_back(fallback_location: root_path)
  end
end
