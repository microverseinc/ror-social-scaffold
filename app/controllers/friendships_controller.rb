class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(friendship_params)
    flash[:notice] = if @friendship.save
                       'Friend request sent.'
                     else
                       'Unable to send friend request.'
                     end
    redirect_to request.referrer
  end

  def update
    requester = User.find params[:user_id]
    if current_user.confirm_friend(requester)
      redirect_back(fallback_location: users_path, notice: 'Friendship request accepted!')
    else
      redirect_back(fallback_location: users_path, notice: 'Friendship request denied!')
    end
  end

  def friendship_requests_delete(requester)
    @friendship = requester.requested_friendships.select do |f|
      f.receiver_id == current_user.id
    end || requester.received_friendships.select do |f|
             f.requester_id == current_user.id
           end
    @friendship
  end

  def destroy
    requester = User.find params[:id]
    @friendship = current_user.requested_friendships.select do |f|
      f.receiver_id == requester.id
    end || current_user.received_friendships.select do |f|
             f.receiver_id == requester.id
           end
    friendship_requests_delete(requester) unless @friendship.any?
    @friendship.each(&:destroy)
    flash[:notice] = 'Deleted succesfully'
    redirect_to request.referrer
  end

  private

  def friendship_params
    { receiver_id: params[:receiver_id],
      requester_id: params[:requester_id],
      status: false }
  end
end
