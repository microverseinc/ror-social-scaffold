class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(friendship_params)
    if @friendship.save
      flash[:notice] = "Friend request sent."
      redirect_to request.referrer
    else
      flash[:notice] = "Unable to send friend request."
      redirect_to request.referrer
    end
  end
  
  def update
    requester = User.find params[:user_id]
    if current_user.confirm_friend(requester)
      redirect_back(fallback_location: users_path, notice: 'Friendship request accepted!')
    else
      redirect_back(fallback_location: users_path, notice: 'Friendship request denied!')
    end
  end

  def destroy
    requester = User.find params[:id]
    @friendship = current_user.requested_friendships.select { |f| f.receiver_id == requester.id } || current_user.received_friendships.select  { |f| f.receiver_id == requester.id }
    unless @friendship.any?
      @friendship =  requester.requested_friendships.select { |f| f.receiver_id == current_user.id } || requester.received_friendships.each { |f| f.requester_id == current_user.id }
    end
    @friendship.each(&:destroy)
    flash[:notice] = "Deleted succesfully"
    redirect_to request.referrer
  end

  private

  def friendship_params
    {receiver_id: params[:receiver_id],
    requester_id: params[:requester_id],
    status: false}
  end

end
