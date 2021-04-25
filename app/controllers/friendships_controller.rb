class FriendshipsController < ApplicationController
  before_action :find_user, only: %i[create friends pending_friends accept_friend]
  
  def create
    friendship = current_user.friendships.create
    friendship.friend_id = @user.id
    if friendship.save
      flash[:success] = "Friendship sent successfully to #{@user.first_name} "
    else
      flash[:danger] = 'Something went wrong '
    end

    redirect_to users_path
  end

  def friends
    @friends = @user.friends
  end

  def pending_friends
    @friends = @user.pending_friends

    render 'friends'
  end

  def friend_requests
    @friends = current_user.friend_requests
  end

  def accept_friend
    if current_user.comfirm_friend(@user)
      flash[:success] = "Friendship confirmed successfully from #{@user.first_name} "
    else
      flash[:danger] = 'Something went wrong '
    end

    redirect_to friend_request_path
  end

  private

  def find_user
    @user = User.friendly.find(params[:id])
  end
end
