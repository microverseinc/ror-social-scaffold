class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @friendships = current_user.friend_requests.uniq
  end

  def create
    user = Friendship.create({user_id: current_user.id.to_i, friend_id: params[:id].to_i})
    second_record = Friendship.create({user_id: params[:id].to_i, friend_id: current_user.id.to_i})
    if user.save && second_record.save
      redirect_to request.referrer, alert: 'Friendship request successfully sent.'
    else
      redirect_to request.referrer, alert: 'Friendship request NOT sent.'
    end
  end

  def update
    friendship = Friendship.find({friendship_id: params[:id].to_i, friend_id: current_user.id.to_i})
    second_record = Friendship.find({user_id: current_user.id.to_i, friend_id: params[:id].to_i})
    if friendship.save && second_record.save
      redirect_to request.referrer, alert: 'Friendship request successfully accepted.'
    else
      redirect_to request.referrer, alert: 'Friendship request NOT accepted.'
    end
  end

  def destroy
    friendship = Friendship.find_by(user_id: params[:id].to_i, friend_id: current_user.id.to_i)
    second_record = Friendship.find_by(user_id: current_user.id.to_i, friend_id: params[:id].to_i)
    if friendship.destroy && second_record
      current_user.friend_requests.delete(friendship)
      redirect_to request.referrer, alert: 'Friendship request declined.'
    else
      redirect_to request.referrer, alert: 'Friendship request could NOT be declined'
    end
  end
end
