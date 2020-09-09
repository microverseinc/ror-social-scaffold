class FriendshipRequestsController < ApplicationController
  before_action :set_user, only: %i[update create destroy]
  before_action :set_request, only: %i[update destroy]

  def create
    friendship = current_user.friendships.build(inverse_friend: @user)

    if friendship.save
      flash[:notice] = "A friendship request was successfully sent to #{@user.name}"
    else
      flash[:alert] = "An error occurred while trying to request the friendship #{friendship.errors.full_messages}"
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
    inverse_friendship = current_user.friendships.build(inverse_friend: @user, status: 'confirmed')

    if inverse_friendship.save
      flash[:notice] = "You are now friends with #{@user.name}"
    else
      errors = inverse_friendship.errors.full_messages
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
  @sent_request = Friendship.find(params[:id])
end
