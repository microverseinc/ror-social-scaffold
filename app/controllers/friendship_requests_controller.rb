class FriendshipRequestsController < ApplicationController
  before_action :set_user, only: [:update, :create]
  def create
    current_user.sent_requests.build(receiver: @user)
    if current_user.save
      flash[:notice] = "A friendship request was successfully sent to #{@user.name}"
    else
      flash[:alert] = "An error occurred while trying to request the friendship #{@user.errors.full_messages}"
    end
    redirect_to user_path(@user.id)
  end

  def update
    sent_request = FriendRequest.find_by(sender_id: params[:user_id])
    sent_request.status = "confirmed"
    if sent_request.save
      flash[:notice] = "The friendship request from #{@user.name} was successfully accepted"
      add_friendship
    else
      flash[:alert] = "An error occurred while trying to accept the friendship #{@user.errors.full_messages}"
    end
    redirect_to user_path(@user.id)
  end

  def add_friendship
    friendship = current_user.friendships.build(inverse_friend: @user)
    inverse_friendship = @user.friendships.build(inverse_friend: current_user)
    
    unless friendship.save && inverse_friendship.save
      errors = []
      errors.concat(current_user.errors.full_messages).concat(@user.errors.full_messages)
      flash[:alert] = "An error occurred while trying to save the friendship #{errors}"
    else
      flash[:notice] = "You are now friends with #{@user.name}"
    end
    
  end
end

private

def set_user
  @user = User.find(params[:user_id])
end

