class FollowsController < ApplicationController

  # see all invitations and friends
  def index

  end
  # send friend request
  def create
    @follow = current_user.followers.new(follower_id: current_user.id, leader_id: params[:user_id])

    if @follow.save
      flash.notice = 'Request sent!'
      redirect_back(fallback_location: root_path)
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:user_id])
    current_user.confirm_friend(@user)
    flash.notice = 'Request Accepted!'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @user = User.find(params[:user_id])
    @follow = current_user.leaders.where("follower_id = ?", @user.id).first
    @follow.destroy
    flash.notice = 'Request rejected!'
    redirect_back(fallback_location: root_path)
  end
end
