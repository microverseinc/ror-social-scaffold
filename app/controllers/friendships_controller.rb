class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @confirmed_friends = current_user.friends
    @sent_requests = current_user.sent_requests
    @incoming_requests = current_user.incoming_requests
  end
  
  def create
    # byebug
    @users = User.all
    @friendship = current_user.friendships.build(friend_id: params[:friend_id], confirmed: false)

    if @friendship.save
      redirect_to user_path(id: params[:friend_id]), notice: 'Friend request sent.'
    else
      redirect_to users_path, error: 'Request not sent. Something is wrong!'
    end
  end

  def update
    # byebug
    @friendship = Friendship.find(params[:id])
    @friendship.confirmed = true
    
    if @friendship.save
      redirect_to friendships_path, notice: 'New friend added successfully!'
    else
      render index, flash.now[:error] = "Couldn't add friend :("
    end
  end

  def destroy
    Friendship.find(params[:id]).destroy
    redirect_to friendships_path, notice: "Friend request canceled/rejected/removed"
  end
end
