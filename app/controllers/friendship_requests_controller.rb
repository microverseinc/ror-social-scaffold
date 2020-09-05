class FriendshipRequestsController < ApplicationController
  before_action :set_user, only: %i[update create destroy]
  before_action :set_request, only: %i[update destroy]

  def create
    current_user.sent_requests.build(receiver: @user)
    if current_user.save
      flash[:notice] = "A friendship request was successfully sent to #{@user.name}"
    else
      flash[:alert] = "An error occurred while trying to request the friendship #{current_user.errors.full_messages}"
    end
    redirect_to user_path(@user.id)
  end

  def update
    @sent_request.status = 'confirmed'
    if @sent_request.save
      add_friendship
    else
      flash[:alert] = "An error occurred while trying to accept the friendship #{@user.errors.full_messages}"
    end
    redirect_to user_path(@user.id)
  end

  def add_friendship
 
    friendship = current_user.friendships.build(inverse_friend: @user)
   
    inverse_friendship = @user.friendships.build(inverse_friend: current_user)

    if friendship.save && inverse_friendship.save
      flash[:notice] = "You are now friends with #{@user.name}"
    else
      errors = []
      errors.concat(friendship.errors.full_messages).concat(inverse_friendship.errors.full_messages)
      flash[:alert] = "An error occurred while trying to save the friendship #{errors}"
    end
  end

  def destroy
    if @sent_request.destroy
      flash[:notice] = "The friendship request from #{@user.name} was successfully rejected"
    else
      flash[:alert] = "An error occurred while trying to reject the friendship #{@user.errors.full_messages}"
    end

    redirect_to user_path(@user.id)
  end
end

private

def set_user
  @user = User.find(params[:user_id])
end

def set_request
  @sent_request = current_user.received_requests.find(params[:id])
end
