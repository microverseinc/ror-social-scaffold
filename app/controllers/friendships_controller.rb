class FriendshipsController < ApplicationController
  def new; end

  def create
    @friendship = Friendship.where('sent_friendship_id = ? AND received_friendship_id = ?',
                                   current_user.id, params[:received_friendship_id])
    if @friendship.count.zero?
      @new_friendship = current_user.friendships.build(received_friendship_id: params[:received_friendship_id])
      if @new_friendship.save
        redirect_to root_path,
                    notice: 'Friend request sent'
      else
        redirect_to root_path,
                    alert: 'Friend request Not sent'
      end

    elsif @friendship.count == 1 && @friendship.confirmed
      redirect_to root_path,
                  alert: 'Already Friends'
    elsif @friendship.count == 1
      redirect_to root_path,
                  notice: 'Friend Request is pending'
    else
      redirect_to root_path,
                  alert: 'Didnt recognise request'
    end
  end

  def show; end

  def destroy; end

  def update
    @friendship = Friendship.find(params[:friendship_id])
    if @friendship.update({ 'status': true })
      redirect_to current_user,
                  notice: 'Friend Request Accepted '
    else
      redirect_to root_path,
                  alert: 'Friend Request Not Accepted'
    end
  end
end
