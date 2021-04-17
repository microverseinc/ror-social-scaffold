class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friendship_params)
    if @friendship.save
      flash[:notice] = "Friend Request Sent."
      redirect_to root_url
    else
      flash[:notice] = "Unable to send friend request."
      redirect_to root_url
    end
  end
  
  def destroy
    requester = User.find params[:user_id]
    @friendship = current_user.friendships.select { |f| f.friend_id == requester.id } || current_user.inverse_friendships.select  { |f| f.friend_id == requester.id }

    unless @friendship.any?
    @friendship =  requester.friendships.each { |f| f.friend_id == current_user.id } || requester.inverse_friendships.each { |f| f.friend_id == current_user.id }
    end
    @friendship.each(&:destroy)
    redirect_to root_url
  end

  private

  def friendship_params
    {friend_id: params[:friend_id],
    confirmed: false}
  end

end


#     friendship = current_user.friendships.each { |f| f.friend_id == requester.id } || current_user.inverse_friendships.each  { |f| f.friend_id == requester.id } || 
#      requester.friendships.each { |f| f.friend_id == current_user.id } || requester.inverse_friendships.each { |f| f.friend_id == current_user.id }