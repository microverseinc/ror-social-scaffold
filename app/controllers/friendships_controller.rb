class FriendshipsController < ApplicationController
  def create
    @request = current_user.sent_friend_requests.build(friend_id: params[:id])
    if @request.save
      flash[:notice] = 'Request Sent'
      redirect_to users_path
    end
  end


  def update
    @request = Friendship.find(params[:id])
    @request.status = :accepted
    if @request.save
      flash[:notice] = "Request Accepted"
      redirect_to users_path
    end
  end
end
