class FriendshipsController < ApplicationController
  def create
    @friend_to_be = User.find(params[:friend_id])
    @inverse_friendship = current_user.inverse_friendships.find_inverse_friendship(@friend_to_be)
    if current_user.id == @friend_to_be.id
      redirect_to users_path, notice: "You can't be friends to yourself, you narsistic!"
    elsif !@inverse_friendship.empty?
      @friend_to_be.confirm_friend(current_user)
      @friendship = current_user.friendships.new(friend_id: @friend_to_be.id, confirmed: true)
      redirect_to users_path, notice: "You can tell everyone, you're friends now!!!" if @friendship.save
    else
      @friendship = current_user.friendships.new(friend_id: @friend_to_be.id, confirmed: false)
      redirect_to users_path, notice: 'You sent a friend request!' if @friendship.save
    end
  end

  def update
    user = User.find_by(id: current_user)
    friend = User.find(params[:friend_id])
    @friendship = Friendship.find_by(user_id: friend, friend_id: user)

    if @friendship.nil?
      redirect_to users_path, notice: 'Are you delusional? How can you confirm a proposition that does not exist?'
    else
      @friendship.confirmed = true
      redirect_to users_path, notice: 'Yeah, you\'re friends for real now! No more pretending!' if @friendship.save
    end
  end

  def destroy
    user = User.find_by(id: current_user)
    friend = User.find(params[:friend_id])
    @friendship = Friendship.find_by(user_id: user, friend_id: friend) || Friendship.find_by(user_id: friend,
                                                                                             friend_id: user)
    if @friendship.nil?
      redirect_to users_path, notice: 'How do you break something that doesn\'t exist?'
    elsif @friendship.destroy
      redirect_to users_path, notice: 'How sad! You\'re no friends no longer!'
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :confirmed)
  end
end
