class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends
    @friend_requests = current_user.friend_requests
  end

  def create
    if Friendship.where(user_id: params[:user_id], friend_id: params[:friend_id], confirmed: false).exists? == false

      @friendship = Friendship.new(user_id: params[:user_id], friend_id: params[:friend_id], confirmed: false)
      if @friendship.save
        redirect_to users_path, notice: 'Friendship request sent'
      else
        redirect_to users_path, alert: 'Friend request wasnt created.'
      end
    else
      redirect_to users_path, notice: 'Friendship request can only be created once.'
    end
  end

  def update
    friendship = Friendship.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
    friendship.confirmed = true

    if Friendship.where(user_id: params[:friend_id], friend_id: params[:user_id]).exists? == false
      inverse = Friendship.new(user_id: params[:friend_id], friend_id: params[:user_id], confirmed: true)
    else
      inverse = Friendship.find_by(user_id: params[:friend_id], friend_id: params[:user_id])
      inverse.confirmed = true
    end

    if friendship.save and inverse.save
      redirect_to friendships_path, notice: 'This is a new Friendship!'
    else
      redirect_to users_path, alert: 'Something went wrong'
    end
  end

  def destroy
    friendship = Friendship.where(user_id: current_user.id, friend_id: params[:user_id]).first
    inverse = Friendship.where(user_id: params[:user_id], friend_id: current_user.id).first
    friendship&.delete
    inverse&.delete
    redirect_to friendships_path
  end
end
