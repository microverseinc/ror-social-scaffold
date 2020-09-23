class FriendshipsController < ApplicationController
    
  def create
    Friendship.create(user_id: current_user.id, friend_id: params[:friend_id], status: 'pending')
  end
  
end

# The button is working, it activates the FriendshipsController#create
# FriendshipsController#create is also working, creating a new item in the table.

# It is saving the current_user.id as the user_id for the Friendship it makes.

