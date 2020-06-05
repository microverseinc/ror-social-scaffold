class FriendshipsController < ApplicationController
  def index
    @friend_list = current_user.friendships.all
  end

  def create
    # error
    @friendship = Friendship.new(
      friend_id: params[:id], user_id: current_user
    )

    if @friendship.save
      puts '-----------------------'
      puts 'ACERTOU'
      puts '-----------------------'
    else
      puts '-----------------------'
      puts 'ERROU'
      puts '-----------------------'
    end
  end

  def destroy
    @relationship = Friendship.find_by(user_id: current_user.id, friend_id: params[:id])
  end
end
