class FriendshipsController < ApplicationController
  
  def index
   
  end
  
  
  def create
    @friendship = Friendship.new
    @friendship.user_id = current_user.id
    @friendship.status = "pending"
    @friendship.friend_id = User.find(user.id)
  end
  
end
