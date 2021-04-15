class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship, only: %i[create destroy]

  def index; end

  def create
    if @friendship.nil?
      @request = Friendship.new(user_id: current_user.id, friend_id: params[:user_id])
      if @request.save
        flash.notice = 'you successfully sent a request!'
        redirect_back(fallback_location: root_path)
      else
        render :new
      end
    else
      flash.notice = 'There is a pending request for this user!'
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @user = User.find(params[:user_id])
    flash.notice = 'Yipee, request accepted!'
    redirect_to users_path
  end

  def destroy
    @friendship.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_friendship
    @friendship = Friendship.find_by(user_id: params[:user_id], friend_id: current_user.id) ||
                  Friendship.find_by(user_id: current_user.id, friend_id: params[:user_id])
  end
end
