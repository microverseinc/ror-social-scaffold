class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.friendships.new
    @friendship.user_id = current_user.id
    @friendship.friend_id = params[:format]
    @friendship.status = false

    if @friendship.save
      redirect_to users_path, notice: 'Friend request sent.'
    else
      redirect_to root_path, alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end

  def update
    user = User.find(params[:format])

    if current_user.confirm_friend(user)
      Friendship.create(user_id: current_user.id, friend_id: user.id, status: true)
      redirect_to user_path(params[:format]), notice: 'Friend request accepted.'
    else
      redirect_to root_path, alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end

  def destroy
    friendship = Friendship.find_by(user_id: params[:format], friend_id: current_user.id)

    if friendship.destroy
      redirect_to root_path, alert: 'Friend request rejected!'
    else
      redirect_to root_path, alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end
end
