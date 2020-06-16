class FriendshipsController < ApplicationController
  include FriendshipsHelper

  def new
    @friendship = Friendship.new
  end

  def create
    requester_id = current_user.id
    @user = User.find_by_id(requester_id)
    @friendship = @user.friendships.build(friendship_params)

    if @friendship.save
      flash.notice = 'Friend Request Succesfully Sent'
      redirect_to user_path(@user)
    else
      flash.alert = @friendship.errors.full_messages[0]
      redirect_to user_path(@user)
    end
  end

  def edit
    
  end

  def update
    @user = current_user.id
    @friendship = Friendship.find_by(confirmer: @user)
    puts "*******- #{@friendship} -*******"
    @friendship.update_attribute(:status, params[:status] = true)

    redirect_to user_path(@user)
  end
end
