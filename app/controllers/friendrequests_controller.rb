class FriendrequestsController < ApplicationController
  def create
    @friendrequest = current_user.friendrequests.new(friend_id: params[:user_id], status: false)

    if @friendrequest.save
      redirect_to users_path, notice: 'new invite sent.'
    else
      redirect_to users_path, alert: 'oops something went.'
    end
  end
end
