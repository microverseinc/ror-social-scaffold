class FriendshipsController < ApplicationController
  def create
    @request = Friendship.new(user_id: params[:user_id], friend_id: params[:friend_id])
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
