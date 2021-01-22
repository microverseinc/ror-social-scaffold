class FriendshipsController < ApplicationController
  def create
    @request = current_user.sent_friend_requests.build(friend_id: params[:id])
    flash[:notice] = if @request.save
                       'Request Sent'
                     else
                       'Something Went Wrong'
                     end
    redirect_to users_path
  end

  def update
    @request = Friendship.find(params[:id])
    @request.status = :accepted
    if @request.save
      flash[:notice] = 'Request Accepted'
    else
      flash[:alert] = 'Something Went Wrong!'
    end
    redirect_to users_path
  end

  def destroy
    @request = Friendship.find(params[:id])
    if @request.destroy
      flash[:notice] = 'Request Rejected'
    else
      flash[:alert] = 'Something Went Wrong!'
    end
    redirect_to users_path
  end
end
